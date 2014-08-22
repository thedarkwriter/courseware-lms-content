# "Package, File, Service" Design Pattern

In the previous resources lesson, Puppet resources were explained, and it was demonstrated how those resource could be combined together to manage services and systems.

This course goes deeper into resources, and demonstrates a practical example of how to manage the Network Time service.

At the end of this course you will be able to:

* explain what a 'Design Pattern' is.
* manage network time, using a design pattern.
* apply the code to the learning vm and test.  

## Slide Content

Design Patterns.
[show jigsaw graphic]

### commentary

"A design pattern is a general repeatable solution to a commonly occurring problem in software design. A design pattern isn't a finished design that can be transformed directly into code. It is a description or template for how to solve a problem that can be used in many different situations."


### slide content
[Show Package File Service Graphic]
### commentary
Here's a simple Puppet design pattern, note how it's made up of three components: package, file and service.
These three components represent Puppet resources that we're going to manage to enable the NTP service.

This is a simple Puppet design pattern.

### slide content

The 'package, file, service' design pattern allows us to compose these Puppet resources together.



### slide content

[Show Package graphic]

### commentary 
The package resource allows us to instruct Puppet to ensure that a particular software package is installed, or absent - where necessary, from our systems.

Software package.

Provides us with software to perform a given function on our systems. 

### slide content

Configuration file.

[show package and file graphic]

To configure the behaviour of the software provided by the package. 

### commentary

The configuration file resource links the management of the package to the management of the service.  The configuration file resource depends on the package resource, which must be satisfied first.


### slide content

Service

[show package, file, service graphic]

Services to perform functions on our systems.
Service behaviour is determined by configuration files. 

### slide content

Package management.

This package resource instructs Puppet to ensure the ntp package is installed.

[show code snippet below]

package { 'ntp':
  ensure => present,
}

### commentary

This resource has the type package, and the title ntp.  ntp is the name that the resource will be referred as, within Puppet.

### slide content

File management.

This file resource instructs Puppet to ensure that the configuration file is present, and that the ntp package is already installed before the configuration file is managed.

[show code snippet below]

file { '/etc/ntp.conf':
  ensure  => file,
  require => Package['ntp'],
}


### commentary

Note the require metaparameter.  This can be used with any resource, and allows ordering of resources.  The require metaparameter causes the referenced resource, which here is 'Package['ntp']', to be enforced before the calling resource 'file '/etc/ntp.conf''.  Notice how the p of package is capitalised within the require metaparameter attribute.  The p is capitalised because we're referring to something already known to Puppet [within the Puppet catalogue.]


### slide 

Service Resource.

service { 'ntpd':
  enable => true,
  ensure => running,
  subscribe => File['/etc/ntp.conf'],
}

### commentary

The subscribe metaparameter can also be used with any resource.  Here the service 'ntpd' is subscribed to the config file '/etc/ntp.conf', such that if the contents of the configuration file change, then the service will be refreshed and reload the new configuration.

Service management.

This service resource instructs Puppet to ensure that the ntpd service is started after the host has booted, and that it must be running.  Also, the subscribe metaparameter directs that if the configuration file changes, the service will be refreshed.


### slide

Putting it all together:

Package Resource & File Resource & Service Resource.

package { 'ntp':
  ensure => present,
}

file { '/etc/ntp.conf':
  ensure  => file,
  require => Package['ntp'],
}

service { 'ntpd':
  enable => true,
  ensure => running,
  subscribe => File['/etc/ntp.conf'],
}  

### commentary

Now let's put everything together, the package resource, file resource and the service resource.  Note that we can specify these resources in any order, but for readability and logical flow, it's helpful for people who'd read your code in the future to structure it in package, file, service order. 
  

### slide

Wrapping it up.

class ntp {

  package { 'ntp':
    ensure => present,
  }

  file { '/etc/ntp.conf':
    ensure  => file,
    require => Package['ntp'],
  }

  service { 'ntpd':
    enable => true,
    ensure => running,
    subscribe => File['/etc/ntp.conf'],
  } 

}

### commentary 

Now we can wrap the resources in a Puppet class, and use the code to classify all required nodes with the ntp service!

All we have to do now is wrap our resource definitions within a class, and we can deploy the Puppet code and manage ntp.


### slide

Conclusion

### commentary

In this lesson, you've learned about some new resource types: package, file, service.

You've learned how resources can be composed together using a design pattern to manage the ntp service.  

## Exercises
Log into your training VM, as root, and follow the steps below:

[1] Execute the command: rpm -e ntp ntpdate --nodeps
[2] Execute the command: cd /etc/puppetlabs/puppet/modules
[3] Execute the command: mkdir -p ntp/{manifests,tests}
[4] Execute the command: vi ntp/manifests/init.pp
[5] Copy and paste the Puppet code above into the file and save it.
[6] Execute the command: vi ntp/tests/init.pp
[7] Enter the text: include ntp
[8] Save and exit from vi.
[9] Execute the command: puppet parser validate ntp/manifests/init.pp
    No response from the command indicates no errors were found in the code.
[10] Execute the command: puppet apply ntp/tests/init.pp
[11] Observe the Puppet output as Puppet installs the ntp, ntpdate packages and 
     starts the ntpd service.     

## Quiz
1. A design pattern is a template which may be used repeatedly to solve a common  
   problem.
	**True**
	
2. Using the following resource declaration, what is the function of the require 
   metaparameter?
   
	file { '/etc/ntp.conf':
	  ensure  => file,
	  require => Package['ntp'],
    }

	a. Causes file /etc/ntp.conf to be managed before package ntp
	b. **Causes file /etc/ntp.conf to be managed after package ntp**
	c. Causes package ntp not to be managed
	d. Causes file /etc/ntp.conf not to be managed.
	
4. Using the following resource declaration, what is the function of the subscribe 
   metaparameter?
   
    service { 'ntpd':
    enable => true,
    ensure => running,
    subscribe => File['/etc/ntp.conf'],
  } 
   
    a. **Causes service ntpd to be refreshed when the contents of /etc/ntp.conf 
       change**
	b. Causes service ntpd to stop when the contents of /etc/ntp.conf change
	c. Causes service ntpd to start when the contents of /etc/ntp.conf change
	d. Causes service ntpd to be enabled when the contents of /etc/ntp.conf change
   
5. True or False. It is always better to use an appropriate Puppet resource over 
   an exec resource.
	**True**



## References
* [Design Pattern](http://sourcemaking.com/design_patterns)