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

  def convert_fields_to_md(fields,lc,path)
    fields.each do |field|
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
  end

  def parse_and_build_structure(lc)
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

     convert_fields_to_md(['content','description','summary'],lc,path)

     File.write("#{path}/metadata.json",lc.delete_if { |k,v| ['content', 'description', 'summary'].include? k }.to_json)
  end

  task :json do
    Dir.glob('**/*metadata.json').each do |path|
      puts path
      json = JSON.parse(File.read(path))
      if json['createdById'].nil?
        # If this field is missing, rewrite to be micheal
        json['createdById'] = 38
      end
      if json['price'].class == Hash
        json['price'] = "#{json['price']['amount']} #{json['price']['currency']}"
      end
      if json['duration'].class == Hash
        ['minutesPerDay','days'].each do |k|
          json["duration.#{k}"] = json['duration'][k]
        end
      end
      json.delete('duration')

      File.write(path,JSON.pretty_generate(json.delete_if { |k,v| ['components'].include? k }))

      if json.has_key?('components')
        json['components'].each do |lc|
          if lc['name']
            puts "Found nested component: #{lc['name']}"
            Dir.chdir(File.dirname(path)) do
              #parse_and_build_structure(lc)
            end
          end
        end
      end
    end
  end

  # Rake Tasks
  task :components do
    # Connect to production or staging
    @lms = connect('staging')

    nested_lcs = {}
    retrieve_all.each do |page,lc|
      parse_and_build_structure(lc)
    end

  end
end

