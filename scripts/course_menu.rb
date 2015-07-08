#! /usr/bin/ruby

self_paced = {
               "1"  => "resources.pp",
               "2"  => "relationships.pp",
               "3"  => "hiera_intro.pp",
               "4"  => "puppet_lint.pp",
               "5"  => "inheritance.pp",
               "6"  => "autoloading.pp",
               "7"  => "facter_intro.pp",
               "8"  => "vim_intro.pp",
               "9"  => "cli_intro.pp",
               "10" => "classes.pp",
               "11" => "testing.pp",
               "12" => "validating.pp",
             }

instructor_led = {
                    "1" => "hiera.pp",
                    "2" => "module.pp",
                    "3" => "code.pp",
                    "4" => "infrastructure.pp",
                    "5" => "default.pp"
                 }

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
puts " [I] Instructor Led Courses"
puts "-----------------------------------------"
puts "Enter course number:"
course_number = gets().chomp

if self_paced.has_key?(course_number)
then
  %x(puppet apply /etc/puppetlabs/puppet/modules/lms/tests/#{self_paced[course_number]})
else
  puts "[1] Practical Hiera Usage"
  puts "[2] Writing Your First Module"
  puts "[3] Managing Puppet Code"
  puts "[4] Infrastructure Design Using Puppet Modules"
  puts "[5] Other Courses"
  puts "Enter course number:"
  course_number = gets().chomp
  if instructor_led.has_key?(course_number)
  then
    %x(puppet apply /etc/puppetlabs/puppet/modules/lms/tests/#{instructor_led[course_number]})
  end
end


# Re-initialize bash to pick up changes
exec ( 'bash' )
