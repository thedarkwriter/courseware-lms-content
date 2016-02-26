# Autoloading #
*Autoloading* in Puppet means that your modules will be loaded by Puppet at compile time, as long as they follow a predictable structure. This course will help you with the basics of Autoloading. 

At the end of this course you will be able to:

* identify your current `modulepath`
* organize your modules in Puppets expected & predicatable structure

## Video ##
[Autoloading](http://d.pr/v/9JFD)

## Transcript ##

## Slide 0



## Slide 1

Classes

Classes define a collection of RESOURCES that are managed together as a single unit.

## Slide 2

Classes

Classes define a collection of RESOURCES that are managed together as a single unit.

## Slide 3

MODULES are self-contained bundles of code and data. 
On disk, a module is simply a directory that contains the files for a given configuration. Because of the pre-defined structure that I just covered you receive the following benefits:
* auto-loading of classes
* file serving (of templates & files)
* auto delivery of extensions
* easy sharing


## Slide 4

On disk, a module is simply a directory tree with a specific, predictable structure:
module-name — This outermost directory’s name matches the name of the module.
  • manifests/ — Contains all of the manifests in the module.
  • init.pp — Contains a class definition. This class’s name must match the module’s name.
  •templates/ — Contains templates, which the module’s manifests can use. See “Templates” for more details.
  • files/ — Contains static files, which managed nodes can download.
  • service.conf — This file’s URL would be puppet:///modules/my_module/service.conf.
  • lib/ — Contains plugins, like custom facts and custom resource types. See “Using Plugins” for more details.
  • tests/ — Contains examples showing how to declare the module’s classes and defined types.
  • spec/ — Contains spec tests for any plugins in the lib directory.

## Slide 5

Puppet searches a specific directory structure to automatically find your classes. This is called the `modulepath`.

## Slide 6

Puppet searches a specific directory structure to automatically find your classes. This is called the `modulepath`.

## Slide 7



## Slide 8

It works like this:
    Modules are just directories with files, arranged in a specific, predictable structure. The manifest files within a module have to obey certain naming restrictions.
    Puppet looks for modules in a specific place (or list of places). This set of directories is known as themodulepath, which is a configurable setting.
    If a class is defined in a module, you can declare that class by name in any manifest. Puppet will automatically find and load the manifest that contains the class definition.

## Slide 9



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



