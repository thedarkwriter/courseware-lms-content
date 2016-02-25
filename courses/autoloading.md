# Autoloading #
*Autoloading* in Puppet means that your modules will be loaded by Puppet at compile time, as long as they follow a predictable structure. This course will help you with the basics of Autoloading. 

At the end of this course you will be able to:

* identify your current `modulepath`
* organize your modules in Puppets expected & predicatable structure

## Video ##
[Autoloading](http://d.pr/v/9JFD)

## Exercises ##
1. Login shells are the programs that users interact with. They interpret commands typed at the command line. We would like to ensure that our system allows users to use the shells we have installed, by listing them in `/etc/shells`.

Execute the following command. This will return the current modulepath for your Puppet installation.

`puppet config print modulepath`

2. Change your current working directory to your module path with:

`cd /etc/puppetlabs/puppet/modules`

3. Examine the directory structure of the example shells module.

<pre>[root@training modules]# tree shells/
shells/
├── files
│   └── shells
├── manifests
│   └── init.pp
├── Modulefile
├── README
├── spec
│   └── spec_helper.rb
└── tests
    └── init.pp
</pre>

4. Edit the main class manifest file inside the shells module to include a class that manages a file resource for `/etc/shells`. If you haven't gone through the [Resources](/learn/resources) lesson, you may use the resource example below.

*   `vim shells/manifests/init.pp`
*   `puppet parser validate shells/manifests/init.pp`

5. Then edit the test manifest to include the class:

*   `vim shells/tests/init.pp`

6. Finally, apply your test to observe any changes being made.

*   `puppet apply shells/tests/init.pp`

Example:

<pre>file { '/etc/shells':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  source => 'puppet:///modules/shells/shells',
}
</pre>

## Quiz ##

1. True or False. Classes define a collection of resources that are managed together as a single unit. (true)
2. Which system configuration setting specifies the location that Puppet will search for your modules?
	a. module_working_dir b. modulepath c. module_repository d. manifestdir (b)
3. A module is simply a directory tree with a specific, predictable structure. Which directory should hold your manifest?
	a. files b. templates c. manifests d. spec (c)
4. When are modules autoloaded?
	a. just before a Puppet run. b. just after a Puppet run. c. at the time of a Puppet run. d. when they are saved to disk (c)
5. Puppet's pre-defined structure allows for all of the following benefits, except:
	a. auto-loading of classes b. file serving c. auto delivery of extensions d. auto declared classes (d)

## Resources ##
* [Module Fundamentals ](http://docs.puppetlabs.com/puppet/2.7/reference/modules_fundamentals.html)
* [Module Structure](http://docs.puppetlabs.com/learning/modules1.html#module-structure)



