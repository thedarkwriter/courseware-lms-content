#! /usr/bin/ruby

puts "Welcome to the PuppetLabs Learning System"
puts "-----------------------------------------"
puts "Press [enter] to continue:"
gets()

# Update courseware content
%x(puppet apply /usr/src/courseware-lms-content/scripts/update.pp)

puts "-----------------------------------------"
puts " [1] Resources"
puts " [2] Relationships"
puts " [3] An Introduction to Hiera"
puts " [4] Puppet Lint"
puts " [5] Inheritance"
puts " [6] Autoloading"
puts " [7] An Introduction to Facter"
puts " [8] An Introduction to Vim"
puts " [9] An Introduction to the Linux Command Line"
puts "[10] Classes"
puts "[11] Instructor Led Courses"
puts "-----------------------------------------"
puts "Enter course number:"
course_number = gets()

if course_number.to_i > 10
  then
  puts "[11] Practical Hiera Usage"
  puts "[12] Writing Your First Module"
  puts "[13] Managing Puppet Code"
  puts "[14] Infrastructure Design Using Puppet Modules"
  puts "Enter course code:"
  course_number = gets()
end

courses = [ "resources.pp",
            "relationships.pp",
            "hiera_intro.pp",
            "puppet_lint.pp",
            "inheritance.pp",
            "autoloading.pp",
            "facter_intro.pp",
            "vim_intro.pp",
            "cli_intro.pp",
            "classes.pp",
            "hiera.pp",
            "module.pp",
            "code.pp",
            "infrastructure.pp",
            "default.pp" ]

%x(puppet apply /etc/puppetlabs/puppet/modules/lms/tests/#{courses[ course_number.to_i - 1 ]})
# Re-initialize bash to pick up changes
exec ( 'bash' )
