# encoding: utf-8
require 'learndot'
require 'learndot/learning_components'
require 'yaml'
require 'json'
require 'kramdown'
require 'stringex'

# This set of tasks are the primary code for uploading content to learndot.

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
    components = @lms.retrieve_component({
      'name' => [ name.to_s ]
    }).to_h

    id = components.select{|id,h| h['name'] == name}.keys.first
    puts "Found existing component with id #{id}"
    # TODO: identify the correct component since this can return multiples
    @lms.update_component(id, conditions) unless id.nil?
  rescue => e
    puts "#{e.message}"
  end

  # Create learning component
  def create(conditions)
    puts "Condtions: #{conditions}"
    @lms.create_component(conditions)
  end

  def convert_to_ascii(string)
    string.gsub(/[”“‘’]/,
      '”' => '"',
      '“' => '"',
      '‘' => '\'',
      '’' => '\''
    )
    string.to_ascii
  end

  # Rake Tasks
  task :component,[:component_directory,:target] do  |_t, args|

    puts 'Connecting to learndot api'
    # Connect to production or staging
    @lms = connect(args[:target])

    # TODO: Decide if we want merge defaults in to allow for sparse
    # json files with only the content that is being managed such as `name`
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
      # We check if the file exists and do not edit the field if it doesn't
      next unless File.exist?("#{component_directory}/#{field}.md")
      markdown = File.read("#{component_directory}/#{field}.md")

      # Check if the file is simply a place holder and just whitespace (blank)
      if /\A[[:space:]]*\z/.match(markdown).nil?
        puts "Converting #{field}.md to html"
        markdown = File.read("#{component_directory}/#{field}.md")

        # Kramdown can't handle non-ascii characters so we check and "fix" if
        # we can. to_ascii comes from the stringex gem above
        unless markdown.force_encoding('UTF-8').ascii_only?
          puts "WARNING: Non ascii characters detected attempting to replace them"
          markdown = markdown.convert_to_ascii
        end
        doc = Kramdown::Document.new(markdown)
        metadata[field] = doc.to_html
      else
        puts "NOTICE: #{component_directory}/#{field}.md is blank, skipping"
      end
    end

    puts metadata.to_json

    # Walk repo to find commit
    git_dir = "./repos/courseware-lms-content"
    repo   = Rugged::Repository.new(git_dir)

    # The sha of the current repo and the download repo (e.g. ./repos) should
    # be the same. This code uses it to create the correct links below.
    sha = File.read('../.git/refs/heads/master') || repo.head.target.oid.to_s

    # Add a series of call back links to the learndot content to make it clear
    # which build ,author and commit generated the html version of the content.
    metadata['customField07']  = "https://pipelines.puppet.com/esquared/builds/#{ENV['DISTELLI_BUILDNUM']}"
    metadata['customField08']  = repo.head.target.author[:name].to_s
    metadata['customField09']  = repo.head.target.summary.to_s
    metadata['customField10'] = "https://github.com/puppetlabs/courseware-lms-content/commit/#{sha}"

    # Check if the LC already exists and update it or create it
    if retrieve(metadata['name']).empty?
      create(metadata)
    else
      update(metadata)
    end

  end
end

