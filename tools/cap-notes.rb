#!/usr/bin/env ruby
require 'nokogiri'

doc = Nokogiri::XML(File.read(ARGV[0]))

slides = doc.css('slide[restype=x-cp-standard-slide]')

slides.each do |slide|
  puts "## " + slide['resname']
  puts
  puts slide.css("group[restype=x-cp-slide-note]").css('source').text
  puts
end

