# Resources  #
Understanding Resources is fundemantal to understanding how Puppet works. Resources are like building blocks (think Lego). They can be combined to model the expected state of the systems you manage.  

At the end of this course you will be able to:

* explain what a Puppet resource is.
* create a Puppet resource using proper syntax.
* examine resources using the `puppet resource` tool.

## Video ##

## Exercises ##
Assuming you have a working Puppet installation:

1. Execute the `puppet resource` command to query the `users` on your system. (Use the Learning VM or your own personal puppet installation.)

## Quiz ##

1. True or False. Resources give the user the ability to model a system's configuration.
	**True**
2. Every resource has a **type**, **title**, and a set of: 
	a. functions
	b. classes 
	c. **attributes**
	d. values
3. Using the following resource declaration, what is the **title** of the resource?
	`file { '/etc/passwd':
		ensure => file,
		owner  => 'root',
		group  => 'root',
		mode   => '0600',  
    	}`

	a. `file`
	b. **`/etc/passwd`**
	c. `owner`
	d. `group`
4. Puppet uses the Resource Abstraction Layer (RAL) to split **types** (high-level models) and:
	a. classes
	b. functions
	c. **providers**
	d. operating systems
5. True or False. Puppet allows you to declare the same resource twice.
	**False**

## References ##
* [Docs](http://docs.puppetlabs.com/puppet/2.7/reference/lang_resources.html)
* [Resource Abstraction Layer](http://docs.puppetlabs.com/learning/ral.html)
* [Puppet Core Types Cheatsheet - PDF](http://docs.puppetlabs.com/puppet_core_types_cheatsheet.pdf)