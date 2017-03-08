#! /usr/bin/env ruby

require 'kramdown'

content = File.open(ARGV[0],"rb").read

puts Kramdown::Document.new(content).to_html
