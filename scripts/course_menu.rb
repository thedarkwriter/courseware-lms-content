#! /usr/bin/ruby

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
puts "[11] Testing"
puts "[12] Validating Puppet Code"
puts "[13] Instructor Led Courses"
puts "-----------------------------------------"
puts "Enter course number:"
course_number = gets()

if course_number.to_i > 12
  then
  puts "[13] Practical Hiera Usage"
  puts "[14] Writing Your First Module"
  puts "[15] Managing Puppet Code"
  puts "[16] Infrastructure Design Using Puppet Modules"
  puts "Enter course number:"
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
            "testing.pp",
            "validating.pp",
            "hiera.pp",
            "module.pp",
            "code.pp",
            "infrastructure.pp",
            "default.pp" ]

%x(puppet apply /etc/puppetlabs/puppet/modules/lms/tests/#{courses[ course_number.to_i - 1 ]})
# Re-initialize bash to pick up changes
exec ( 'bash' )
