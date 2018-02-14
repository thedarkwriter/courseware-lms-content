# encoding: utf-8
require 'rugged'
require 'fileutils'
require 'yaml'


namespace :create do
  task :component do
    def cputs(string)
      STDOUT.puts "\033[1m#{string}\033[0m"
    end

    def read_file(file,line_number)
      IO.readlines(file)[line_number]
    end

    def read_json(path)
      puts "Parsing json file (#{path})"
      JSON.parse(File.read(path))
    end

    def normalize_name(name)
      name.lstrip.downcase.gsub(/(:|"|\.| |&|-)/,'_').squeeze('_')
    end

    def ask_questions(questions,question_type = :simple)
      questions.each do |key,hash|
        cputs hash[:query]
    
        STDOUT.puts hash[:description] if hash[:description]
        STDOUT.print "  [%s]: " % hash[:default]
    
        answer = STDIN.gets.chomp.strip
    
        case question_type
        when  :boolean
         if answer.nil? or answer.empty?
           return hash[:default].scan /\p{Upper}/
         else
           return answer  =~ (/(yes|y)/i)  ? true : false
         end
        when :simple
          if answer.nil? or answer.empty?
            return hash[:default]
          else
            return answer.delete('\\')
          end
        end
      end
    end

    def git_commit_file(lc_directory)
      directory = "_lmscontent/#{lc_directory}"
      repo   = Rugged::Repository.new(File.dirname(File.dirname(File.dirname(__FILE__))))
      # `git add file`
      index = repo.index
      ['content.md','description.md','summary.md','metadata.json'].each do |file|
        file.slice!(repo.workdir)
        index.add(:path => "#{directory}/#{file}",
                  :oid  => Rugged::Blob.from_workdir(repo, "#{directory}/#{file}"),
                  :mode => 0100644)
      end
      # `git commit -m 'Initial Commit'`
      options = {}
      index.write
      author = {:email=>"zack@puppet.com", :time=>Time.now, :name=>"Zack Smith"}
      options[:author]     = author
      options[:message]    = 'Initial Commit'
      options[:committer]  = author
      options[:parents]    = repo.empty? ? [] : [repo.head.target_id].compact
      options[:update_ref] = 'HEAD'
      options[:tree]       = index.write_tree
      oid                  = Rugged::Commit.create(repo, options)
      if oid
        cputs "Created commit Initial Commit"
        cputs repo.status { |file, status_data| puts "#{file} has status: #{status_data.inspect}" }
      else
        raise "Something went wrong with the commit"
      end
      oid
    end

    unless ask_questions({
      :create_learning_component => {
        :query       => 'Would you like to create a learning component?',
        :description => 'A new folder will be created, along with default metadata.json',
        :default     => 'Y/n',
      },
    }, :boolean)
      exit 1
    end
    @name = ask_questions(
      {
        :name => {
          :query   => 'What is the name of the learning component',
          :default => 'This - An Example',
        },
      },
    :simple)

    @days = ask_questions(
      {
        :days => {
          :query   => 'How many days is the component?',
          :default => 0,
        },
      },
    :simple)

    @minutes_per_day = ask_questions(
      {
        :days => {
          :query   => 'How many minutes per day?',
          :default => 30,
        },
      },
    :simple)

    @dir_name = normalize_name(@name) 

    if !File.directory?(@dir_name)
      Dir.mkdir(@dir_name)
    end
    # Create the skeleton
    ['content.md','summary.md','description.md'].each do |file|
      FileUtils.touch("#{@dir_name}/#{file}")
    end

    json     = read_json('_tasks/defaults.json')

    json['name']                   = @name
    json['urlName']                = normalize_name(@name).gsub('_','-')
    json['duration.minutesPerDay'] = @minutes_per_day
    json['duration.days']          = @days

    File.write("#{@dir_name}/metadata.json", JSON.pretty_generate(json))

    #if ask_questions({
    #    :commit_file => {
    #      :query       => 'Would you like to commit the learning component?',
    #      :description => 'The learning component will be added to the local branch',
    #      :default     => 'Y/n',
    #    },
    #  }, :boolean)
    #  git_commit_file(@dir_name)
    #end
    # Only works on macOS
    system("open '#{@dir_name}'")
  end
end

