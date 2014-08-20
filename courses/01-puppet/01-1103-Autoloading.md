# Autoloading #
*Autoloading* in Puppet means that your modules will be loaded by Puppet at compile time, as long as they follow a predictable structure. This course will help you with the basics of Autoloading. 

At the end of this course you will be able to:

* identify your current `modulepath`
* organize your modules in Puppets expected & predicatable structure

## Video ##
[Autoloading](http://d.pr/v/9JFD)

## Exercises ##
Assuming you have a working Puppet installation:

1. Execute `puppet config print modulepath`. This will return the current `modulepath` for your Puppet installation.

## Quiz ##

1. True or False. Classes define a collection of resources that are managed together as a single unit. (true)
2. A module is simply a directory tree with a specific, predictable structure. Which directory should hold your manifest?
	a. files b. templates c. manifests d. spec (c)
3. Which system configuration setting specifies the location that Puppet will search for your modules?
	a. module_working_dir b. modulepath c. module_repository d. manifestdir (b)
4. When are modules autoloaded?
	a. just before a Puppet run. b. just after a Puppet run. c. at the time of a Puppet run. d. when they are saved to disk (c)
5. Puppet's pre-defined structure allows for all of the following benefits, except:
	a. auto-loading of classes b. file serving c. auto delivery of extensions d. auto declared classes (d)

## Resources ##
* [Module Fundamentals ](http://docs.puppetlabs.com/puppet/2.7/reference/modules_fundamentals.html)
* [Module Structure](http://docs.puppetlabs.com/learning/modules1.html#module-structure)



