#! /usr/bin/ruby

self_paced = {
  "A"  => { :name => "Resources", :file => "resources.pp"},
  "B"  => { :name => "Relationships", :file => "relationships.pp"},
  "C"  => { :name => "An Introduction to Hiera", :file => "hiera_intro.pp"},
  "D"  => { :name => "Puppet Lint", :file => "puppet_lint.pp"},
  "E"  => { :name => "Inheritance", :file => "inheritance.pp"},
  "F"  => { :name => "Autoloading", :file => "autoloading.pp"},
  "G"  => { :name => "An Introduction to Facter", :file => "facter_intro.pp"},
  "H"  => { :name => "An Introduction to Vim", :file => "vim_intro.pp"},
  "I"  => { :name => "An Introduction to the Linux Command Line", :file => "cli_intro.pp"},
  "J" => { :name => "Classes", :file => "classes.pp"},
  "K" => { :name => "Testing", :file => "testing.pp"},
  "L" => { :name => "Validating Puppet Code", :file => "validating.pp"},
}

instructor_led = {
  "A" => { :name => "Practical Hiera Usage", :file => "hiera.pp"},
  "B" => { :name => "Writing Your First Module", :file => "module.pp"},
  "C" => { :name => "Managing Puppet Code", :file => "code.pp"},
  "D" => { :name => "Infrastructure Design Using Puppet Modules", :file => "infrastructure.pp"},
  "E" => { :name => "Other Courses", :file => "default.pp"},
}

puts "-----------------------------------------"
self_paced.sort_by{|k,v|k}.each do |letter, course|
  printf("[%s] %s\n", letter, course[:name])
end
puts "[Z] Instructor Led Courses"
puts "-----------------------------------------"
puts "Enter course letter:"
course_letter = gets().chomp.upcase

if self_paced.has_key?(course_letter)
  then
  %x(puppet apply /etc/puppetlabs/puppet/modules/lms/tests/#{self_paced[course_letter][:file]})
else
  instructor_led.sort_by{|k,v|k}.each do |letter, course|
    printf("[%s] %s\n", letter, course[:name])
  end
  puts "Enter course letter:"
  course_number = gets().chomp.upcase
  if instructor_led.has_key?(course_letter)
    then
    %x(puppet apply /etc/puppetlabs/puppet/modules/lms/tests/#{instructor_led[course_letter][:file]})
  end
end


# Re-initialize bash to pick up changes
exec ( 'bash' )
