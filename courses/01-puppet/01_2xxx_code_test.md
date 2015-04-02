# Validating your Puppet Code

Before testing to see whether your manifest and modules are delivering the results that you expect, you need to validate your Puppet code syntax and check that you have followed established style conventions.  In this course we look at the first level of testing, validating your Puppet code, using the Puppet Language Style Guide, Puppet parser, and puppet lint.

At the end of this course you will be able to:

* Access the Puppet Language Style Guide. 
* Use Puppet parser to validate Puppet code syntax.
* Install puppet-lint.
* Use puppet-lint to compare your manifests to established coding standards. 

# Slide Content

## This is the content for the instructional video.

### slide Title - Validating your Puppet Code

Before testing to see whether your manifest and modules are delivering the results that you expect, you need to validate your Puppet code syntax and check that you have followed established style conventions.  In this course we look at the first level of testing, validating your Puppet code, using the Puppet Language Style Guide, Puppet parser, and puppet lint.

### slide Automate

Puppet is about automating the management of your IT infrastructure, large or small, simple or complex. And Puppet is especially concerned with managing the entire life cycle of your infrastructure, fixing or updating configuration files and automatically restarting services. But all of this only works if your modules are written correctly, which proper testing can ensure. We have a number of tools and frameworks available to help you test your modules. But first, a brief review of Puppet's structure and some best practices for writing Puppet modules.

### slide Puppet Structure

The core of the Puppet language is the resource declaration. A resource declaration describes a desired state for one resource. Classes are are individual Puppet resources bundled together to define a single idea, and the primary means by which Puppet Enterprise configures nodes.  Manifests are Puppet programs. They are standard text files, and they hold class definitions and other logic for Puppet to use. Manifests are always saved with a dot p p extension.

### slide Puppet Enterprise Modules

Modules are self-contained bundles of code and data. On disk, a module is a directory tree with a specific, predictable structure. The module name is the outermost directory’s name. 

The manifests directory contains all of the manifests in the module. This directory should contain an `init.pp` manifest where the class name matches the module name. 

In the module directory there are two sub-directories that you use for Puppet testing. The tests directory contains examples showing how to declare the module's classes and defined types.  Each class or type should have an example in the tests directory. The spec directory is where you put spec and server spec tests that you use to test plugins in the lib directory.

### slide Module Paths

One final note about Puppet structure -  with Puppet Enterprise, modules installed by Puppet, modules you download from the Puppet Forge, and modules that you create to manage nodes are located in the directory /etc/puppetlabs/puppet/environments/production/modules. Puppet Enterprise also installs modules in the /opt/puppet/share/puppet/modules directory. You should not modify anything in or add any modules to this directory.

### slide Puppet Modules

Next-  a quick review of best practices for writing your Puppet modules. To write your modules, we strongly suggest that you run the command puppet module generate, with your username, a hyphen, and a name for the module that you wwant to create. When you run this command, the Puppet module tool gathers metadata about your module, through a series of questions, and creates a basic module structure for you, including your spec and tests directories and the appropriate files in those directories. 

### slide Puppet Module Tool 

This is an example of the output from Puppet after you run the puppet generate module command. 

You also have the option of writing classes and defined types by hand and placing them in properly named manifest files. If you decide to create the module manually, you must be sure that your metadata.json file is properly formatted or your module will not work. Why not use the automated Puppet module tool and avoid any possible complications?

### slide More about Puppet Modules

And remember, if you want to use modules written by others users, run the `puppet module install` command.

For more information about writing Puppet modules, you can refer to our online documentation at docs dot puppetlabs dot com., and the Puppet Forge, a repository of modules written by our community.

### slide Style Guide

So, you have written a great module starting with the Puppet module tool. Next you can use the Puppet Language Style Guide to ensure that your modules work as expected and adhere to established standards. You can find the style guide on the Puppet Labs website.

The purpose of this style guide is to promote consistent module formatting across Puppet Labs and the Puppet community, which gives users and developers of Puppet modules a common pattern and design to follow. Consistency in code and module structure makes continued development and contributions easier.

### slide Guiding Principles

We can never cover every possible circumstance you might run into when developing Puppet code or creating a module. Eventually, a judgement call will be necessary. When that happens, keep in mind some general principles:

First, readability matters.If you have to choose between two equally effective alternatives, pick the more readable one. While this is subjective, if you can read your own code three months from now, it’s a great start. In particular, code that generates readable diffs is highly preferred.
Next, scoping and simplicity are key.When in doubt, err on the side of simplicity. A module should contain related resources that enable it to accomplish a task. If you describe the function of your module and you find yourself using the word ‘and,’ it’s time to split the module at the ‘and.’ You should have one goal that all your classes and parameters focus on achieving.
And third, your module is a piece of software. And you should treat it that way. When it comes to making decisions, choose the option that is cleanest and easiest to maintain for the long term.


## Exercises

## Quiz

## References