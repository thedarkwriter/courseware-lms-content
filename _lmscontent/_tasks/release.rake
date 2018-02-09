require 'rugged'
require 'pathname'

namespace :release do
  desc 'Build LMS content and upload a release to staging'
  task :staging do

    # Update the reposositories from github
    Rake::Task['download:repos'].invoke

    @config['repos'].each do |key,hash|
      # Push every commit to staging
      # Once repo is up to date , pull new commits from today
      git_dir = "./repos/#{key}"

      # Walk repo to find commits by date
      repo   = Rugged::Repository.new(git_dir)
      walker = Rugged::Walker.new(repo)
      walker.sorting(Rugged::SORT_DATE| Rugged::SORT_REVERSE)
      walker.push(repo.head.target)

      walker.each do |commit|
        c_time = Time.at(commit.time)
        # Find all commits that happen today or after today
        next unless c_time >=  Date.today.to_time
          # Diff the commits and their parent
          commit.parents[0].diff(commit).each_delta do |delta|
            # Join the path with path repo and read the file into Kramdown
            next unless delta.new_file[:path] =~ %r{.*\.md$}
            next unless delta.new_file[:path] =~ %r{_lmscontent/.*$}
            next if     delta.new_file[:path] =~ %r{.*README.md$}
            
            component_directory = Pathname.new(delta.new_file[:path]).parent.basename
            puts "Found updated component #{component_directory}"
            Rake::Task["release:#{component_directory}"].invoke('staging') 
          end
      end  
    end
  end
  desc 'Build LMS content and upload a release to production'
  task :production do
    # Update the reposositories from github
    Rake::Task['download:repos'].invoke

    # Push version tags to production
    # Find the latest git tag by date & time
    tags = repo.references.each("refs/tags/v*").sort_by{|r| r.target.epoch_time}.reverse!

    raise "Can't deploy to production No matching (v*) tags found on this repository!" if tags[0].nil?

    # Use the last commit in the repo if only one tag exists
    parent = tags[1].nil? ? repo.last_commit : tags[1].target

    # Compare that tag to the tag that historically preceded it
    parent.diff(tags[0].target).each_delta do |delta|
    # Join the path with path repo and read the file into Kramdown
    next unless delta.new_file[:path] =~ %r{.*\.md$}
    next unless delta.new_file[:path] =~ %r{_lmscontent/.*$}
    next if     delta.new_file[:path] =~ %r{.*README.md$}

    component_directory = Pathname.new(delta.new_file[:path]).parent.basename

    Rake::Task["release:#{component_directory}"].invoke('production')
    end
  end
end

