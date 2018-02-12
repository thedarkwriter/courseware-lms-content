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

    # Only works on macOS
    system("open '#{@dir_name}'")
  end
end

