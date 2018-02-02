# encoding: utf-8
require 'learndot'
require 'learndot/learning_components'
require 'yaml'
require 'json'
require 'kramdown'
require 'upmark'
namespace :migrate do

  # Connect to the learndot api
  def connect(target)
    # https://github.com/puppetlabs/learndot_api/blob/e1df5b0e1c64b09e7e48c504e98e2f3645f2eaf9/lib/learndot.rb#L22
    staging = target == 'production'  ? false : true

    # Configure the token for the target
    ENV['LEARNDOT_TOKEN'] = @config['credentials']['learndot'][target]['token']

    @lms = @lms || Learndot.new(true, staging).learning_component
  end

	# Show learning components 
  def retrieve_all()
    @lms.retrieve_component({}).to_h
  rescue => e
    puts "#{e.message}"
    {}
  end

  def normalize_name(name)
    name.lstrip.downcase.gsub(/(:|"|\.| |&|-)/,'_').squeeze('_')
  end

  # Rake Tasks
  task :components do
    # Connect to production or staging
    @lms = connect('staging')

    require 'pp'

    nested_lcs = {}
    retrieve_all.each do |page,lc|
      # .gsub(/\w-/,' -') is to fix word- instead of word -
      match = lc['name'].gsub(/\w-/,' -').match(
        /(?<number>^[0-9]+\.(\s|\w))?(?<parent>.*(\s-\s|:))?(?<name>.*$)/
      )
      if match['parent']
        parent_dir = normalize_name(match['parent'].gsub(/ - /,''))
        child_dir  =  normalize_name("#{match['number']}#{match['name']}")
        path = "#{parent_dir}/#{child_dir}"
      else
        path = normalize_name(match['name'])
      end
      puts path
      FileUtils.mkdir_p path
      [
        'content',
        'description',
        'summary',
      ].each do |field|
        unless lc[field].nil?
          begin
            md = Upmark.convert(lc[field])
          rescue
            begin
              md = ReverseMarkdown.convert(lc[field])
            rescue
              md = lc[field]
            end
          end
          File.write("#{path}/#{field}.md",md)
        end
      end
      File.write("#{path}/metadata.json",lc.delete_if { |k,v| ['content', 'description', 'summary'].include? k }.to_json)
    end

  end
end

