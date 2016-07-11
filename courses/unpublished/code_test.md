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

### slide Puppet Modules

Next -  a quick review of best practices for writing your Puppet modules. To write your modules, we strongly suggest that you run the command puppet module generate, with your username, a hyphen, and a name for the module that you want to create. When you run this command, the Puppet module tool gathers metadata about your module, through a series of questions, and creates a basic module structure for you, including directories for testing and the appropriate files in those directories.  

### slide Puppet Module Tool 

This is an example of the output from Puppet after you run the puppet generate module command. You can also write classes and defined types by hand, and place them in properly named manifest files. But, if you decide to create the module manually, you have to be sure that your metadata.json file is properly formatted or your module won't work. so, why not use the automated Puppet module tool and avoid possible complications?

### slide More about Puppet Modules

And remember, if you want to use modules written by others users, run the `puppet module install` command.

For more information about writing Puppet modules, you can refer to our online documentation at docs dot puppetlabs dot com., and the Puppet Forge, a repository of modules written by our community.

### slide Style Guide

So, you have written a great module starting with the Puppet module tool. Next you can use the Puppet Language Style Guide to ensure that your modules adhere to established standards. You can find the style guide on the Puppet Labs website.

The purpose of this style guide is to promote consistent module formatting across Puppet Labs and the Puppet community, which gives users and developers of Puppet modules a common pattern and design to follow. Consistency in code and module structure makes continued development and contributions easier.

### slide Guiding Principles

We can never cover every possible circumstance you might run into when developing Puppet code or creating a module. Eventually, a judgement call will be necessary. When that happens, keep in mind some general principles: First, readability matters.If you have to choose between two equally effective alternatives, pick the more readable one. While this is subjective, if you can read your own code three months from now, it’s a great start. In particular, code that generates readable diffs is highly preferred.Next, scoping and simplicity are key.When in doubt, err on the side of simplicity. A module should contain related resources that enable it to accomplish a task. If you describe the function of your module and you find yourself using the word ‘and,’ it’s time to split the module at the ‘and.’ You should have one goal that all your classes and parameters focus on achieving.And third, your module is a piece of software. So treat it that way. When it comes to making decisions, choose the option that is cleanest and easiest to maintain for the long term.

### Puppet Parser

So, after you have written your Puppet code, the first level of testing is syntax validation. Typos and errors are bound to creep into code. You can use Puppet parser to make sure that your manifest can be parsed before you commit your changes or deploy them to a live environment. 

Puppet parser validates Puppet DSL syntax without compiling a catalog or syncing any resources. If no manifest files are provided, it validates the default site manifest.

For example, let's say you left out a curly brace. If you run the command puppet parser validate, you would receive output that looks like this text. Puppet tells you what went wrong and which line contains the error so that you can easily find and correct the mistake in your manifest. If Puppet returns nothing after you run the command, no syntax errors were encountered.

### slide puppet-lint

The next level of testing you can perform is to check your manifest for deviations from the Puppet Language Style Guide. Puppet-lint is a third-party tool that you can use to compare your manifest to a checklist of coding conventions. Then, Puppet suggests changes to help you align your code with Puppet's style guide.

### slide Install and Run puppet-lint

puppet-lint is packaged as a Ruby Gem, so you can use the RubyGems tool to install it. Then you can test a single manifest by running puppet lint and the path to the file.

### slide Fix a File

Running puppet-lint against a manifest could produce something like this output. Puppet identifies deviations from the Puppet Language style guide and the lines they appear on. Then you can fix your code and re-run puppet-lint.

Or, if you prefer, you can run puppet-lint --fix and Puppet fixes any errors as they are found.

### slide puppet-lint require

If you want to test your entire Puppet manifests directory, you can add require 'puppet-lint/tasks/puppet-lint' to your Rakefile. Then from your manifests directory run the command rake lint.

Running puppet-lint against a manifest could produce something like this output. Puppet identifies deviations from the Puppet Language style guide and the lines they appear on. Then you can fix your code and re-run puppet-lint.

Or, if you prefer, you can run puppet-lint --fix and Puppet fixes any errors as they are found.

Puppet lint is a quick and easy way to ensure that as you grow your collection of modules, everybody is following a common set of conventions.

### slide puppet-lint Conclusion

Puppet lint is a quick and easy way to ensure that as you grow your collection of modules, everybody is following a common set of conventions. For more information, you can view the puppet lint project on github and read more documentation at puppet lint dot com.

### slide Next steps

Now that you have some tools to check you Puppet code syntax and style guidelines, you are ready to begin testing your modules for expected behaviors. In the following lessons we introduce tools and techniques for unit and acceptance testing. 

To check your knowledge, click the link on the bottom of this course's page and complete the short quiz. There is also a link to additional learning resources.


## Exercises

## Quiz

## References

https://github.com/rodjek/puppet-lint

http://puppet-lint.com

https://docs.puppetlabs.com/references/3.4.0/man/parser.html