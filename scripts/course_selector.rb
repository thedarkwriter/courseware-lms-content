#! /usr/bin/ruby

puts "Welcome to the PuppetLabs Learning System"
puts "-----------------------------------------"
puts "Press [enter] to continue:"
gets()

# Update courseware content
%x(puppet apply /usr/src/courseware-lms-content/scripts/update.pp)

# Run Course Menu
exec '/usr/local/bin/course_menu'
