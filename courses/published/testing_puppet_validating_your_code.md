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

To check your knowledge, click the link on the bottom of this course's page and complete the short quiz. There is also a link to additional learning resources.


## Exercises

## Quiz

## References

https://github.com/rodjek/puppet-lint

http://puppet-lint.com

https://docs.puppetlabs.com/references/3.4.0/man/parser.html


## Exercise

1. Run `puppet agent -t` to set up the sample code.

1. Run Puppet Parser on the sample manifest file.

<pre>puppet parser validate /root/puppetcode/modules/ntplint/manifests/init.pp
</pre>

Puppet will return the following error message:  

<pre>Error: Could not parse for environment production: Syntax error at '{' at /root/puppetcode/
modules/ntplint/manifests/init.pp:3:68
</pre>

1. Edit the manifest to correct the issue.

<pre>vim /root/puppetcode/modules/ntplint/manifests/init.pp
</pre>

1. Run Puppet Parser again. Edit the file to correct the following error. And the run Puppet Parser once again to confirm that the code compiles.

<pre>Error: Could not parse for environment production: Syntax error at 'ntp' at /root/puppetcode/modules/ntplint/manifests/init.pp:47:21
</pre>

1. Run Puppet Lint on the sample manifest file.

<pre>puppet-lint /root/puppetcode/modules/ntplint/manifests/init.pp
</pre>

Puppet-lint will return the following list of warnings:

<pre>WARNING:top-scope variable being used without an explicit namespace on line 5 
WARNING:double quoted string containing no variables on line 10 
WARNING:string containing only a variable on line 39 WARNING: unquoted resource title on line 38WARNING:ensure found on line but it's not the first attribute on line 40
</pre>

1. Edit the manifest to correct these issues:

<pre>vim /root/puppetpuppet/modules/ntplint/manifests/init.pp
</pre>

1. Run puppet-lint again to see the result:

<pre>puppet-lint /root/puppetpuppet/modules/ntplint/manifests/init.pp
</pre>

1. Continue editing and checking until there are no remaining warnings.


## Quiz
1. What is the function of Puppet parser?
a. Puppet parser checks your code for deviations from the recommended coding styles and formats.
b. Puppet parser automatically builds the initial structure for your manifests.
(c.) Puppet parser validates Puppet DSL syntax without compiling a catalog or syncing any resources.
d. Puppet parser confirms the validity of the logic of your modules.

1. (True) or False. You can use puppet-lint to find and fix deviations from the Puppet Language Style Guide in your manifests.

1. True or (False). Validating puppet code is the last step before deploying puppet modules.

