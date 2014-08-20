# Classes
Classes define a collection of resources that are managed together as a single unit. You can also think of them as named blocks of Puppet code, which are created in one place and invoked elsewhere.

At the end of this course you will be able to:

* describe Puppet Resources & Classes.
* create a class using proper syntax.
* differentiate between defining and declaring classes.

## Video ##

## Exercises ##
Assuming you have a working Puppet installation:

1. Execute the `puppet resource` command to query the `users` on your system. (Use the Learning VM or your own personal puppet installation.)

## Quiz ##

1. True or False. A class is made up of Puppet resources.
	**True**

2. True or False. Defining a class automatically includes it in your configuration.
	**False**

3. Using the following example, how many resources are being defined?

`class ssh {	  package  { 'openssh-clients':	    ensure => present,	  }	  file { '/etc/ssh/ssh_config':	    ensure  => file,			owner   => 'root',	    group   => 'root',	    source  => 'puppet:///modules/ssh/ssh_config',	  }	  service { 'sshd':	    ensure => running,	    enable => true,	  }	}`a. 1
b. 2
c. **3**
d. 44. Using the following example, what is the title of the class?

`class ssh {	  package  { 'openssh-clients':	    ensure => present,	  }	  file { '/etc/ssh/ssh_config':	    ensure  => file,			owner   => 'root',	    group   => 'root',	    source  => 'puppet:///modules/ssh/ssh_config',	  }	  service { 'sshd':	    ensure => running,	    enable => true,	  }	}`

a. **ssh**
b. openssh-clients
c. sshd
d. ssh_config

5. True or False. Puppet classes are reusable and singleton.
	**True**

## References ##
* [Modules & Classes](http://docs.puppetlabs.com/learning/modules1.html)
* [Classes - Docs](http://docs.puppetlabs.com/puppet/3/reference/lang_classes.html)