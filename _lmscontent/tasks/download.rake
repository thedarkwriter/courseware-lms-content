require 'rugged'
require 'yaml'


namespace :download do
  task :repos do

    config = YAML.load_file('config.yaml')

    # First time run initialize
    unless File.directory?('repos')
      FileUtils.mkdir('repos')
    end

    credentials = Rugged::Credentials::UserPassword.new({
      username: config['credentials']['github']['user'],
      password: config['credentials']['github']['token']
    })

    config['repos'].each do |key,hash|
      puts "Updating repo #{key} #{hash['url']}"
      if Dir.exist?("repos/#{key}")
        # If repo already exists fetch and reset (pull)
        repo = Rugged::Repository.discover("repos/#{key}")
        repo.remotes['origin'].fetch(credentials: credentials)
        repo.reset("origin/#{hash['branch']}",:hard)

      else
        # Clone the repo on the initial run
        Rugged::Repository.clone_at(hash['url'], "repos/#{key}", {
          credentials: credentials,
          checkout_branch: hash['branch']
        })
        repo = Rugged::Repository.discover("repos/#{key}")
        remotes = Rugged::RemoteCollection.new(repo)
        remotes.create('upstream',hash['url'])

      end
    end
  end
end

