# encoding: utf-8
require 'rugged'
require 'yaml'

# Puppet pipelines clones a "shallow" repo for its build process. 
# libgit2 does not support these https://github.com/libgit2/rugged/issues/409
# This task works around this by cloning the entire repo using the Github
# API personal token.
# TODO: Decided if we should us an absolute path instead of the realtive
# "repos" path. The realtive path may be better for desktop users
# However using an absolute might speed things up as we can just fetch the
# deltas.

namespace :download do
  task :repos do

    # First time run initialize
    unless File.directory?('repos')
      FileUtils.mkdir('repos')
    end

    credentials = Rugged::Credentials::UserPassword.new({
      username: @config['credentials']['github']['user'],
      password: @config['credentials']['github']['token']
    })

    @config['repos'].each do |key,hash|
      puts "Updating repo #{key} #{hash['url']}"

      sha = File.read('../.git/refs/heads/master')
      if Dir.exist?("repos/#{key}")
        # If repo already exists fetch and reset (pull)
        repo = Rugged::Repository.discover("repos/#{key}")
        repo.remotes['origin'].fetch(credentials: credentials)
        repo.reset(sha,:hard)

      else
        # Clone the repo on the initial run
        # This is likely always run when pipelines runs this task as from
        # a fresh build directory. The sha thats checkouted is the sha of the
        # shallow repo as thats the commit that kicked off this run.
        Rugged::Repository.clone_at(hash['url'], "repos/#{key}", {
          credentials: credentials,
          checkout: sha 
        })
        # Reset local repo to be sha of pipelines shallow repo.
        repo = Rugged::Repository.discover("repos/#{key}")
        remotes = Rugged::RemoteCollection.new(repo)
        remotes.create('upstream',hash['url'])

      end
    end
  end
end

