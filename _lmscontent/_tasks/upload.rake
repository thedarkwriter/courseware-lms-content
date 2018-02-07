# encoding: utf-8
require 'learndot'
require 'learndot/learning_components'
require 'yaml'
require 'json'
require 'kramdown'

namespace :upload do

  # Connect to the learndot api
  def connect(target)
    # https://github.com/puppetlabs/learndot_api/blob/e1df5b0e1c64b09e7e48c504e98e2f3645f2eaf9/lib/learndot.rb#L22
    staging = target == 'production'  ? false : true

    # Configure the token for the target
    ENV['LEARNDOT_TOKEN'] = @config['credentials']['learndot'][target]['token']

    @lms = @lms || Learndot.new(true, staging).learning_component
  end

	# Show learning components 
  def retrieve(name)
    @lms.retrieve_component({
      'name' => [ name.to_s ]
    }).to_h
  rescue => e
    puts "#{e.message}"
    {}
  end

  # Update learning component
  def update(conditions)
    # Assume name is always in metadata
    name = conditions['name']
    @lms = connect
    components = lms.retrieve_component({
      'name' => [ name.to_s ]
    }).to_h

    # TODO: identify the correct component since this can return multiples
    @lms.update_component(component[id], conditions) unless id.nil? || id.empty?
  rescue => e
    puts "#{e.message}"
  end

  # Create learning component
  def create(conditions)
    @lms.create_component(conditions)
  end

  # Rake Tasks
  task :component,[:component_directory,:target] do  |_t, args|
    # Connect to production or staging
    @lms = connect(args[:target])

    #defaults = JSON.parse(File.read('defaults.json'))

    component_directory = args[:component_directory]

    #metadata = defaults.merge(JSON.parse(File.read("#{component_directory}/metadata.json")))

    metadata = JSON.parse(File.read("#{component_directory}/metadata.json"))
    # Loop over fields that are broken out as markdown files
    [
      'content',
      'description',
      'summary',
    ].each do |field|
      doc = Kramdown::Document.new(File.read("#{component_directory}/#{field}.md"))
      metadata[field] = doc.to_html
    end

    puts metadata.to_json

    # Check if the LC already exists and update it or create it
    if retrieve(metadata['name']).empty?
      create(metadata)
    else
      update(metadata)
    end

  end
end

