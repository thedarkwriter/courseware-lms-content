# Testing Puppet: Unit Tests

As your codebase grows in complexity, changing one part of the code without affecting other parts becomes exponentially more difficult. Unit tests are a method for ensuring that individual parts of your codebase continue to work as intended while other parts are improved and refactored as needed.

At the end of this course you will be able to:

* Explain the purpose of unit testing.
* Describe methods for using spec-puppet to test.
* Identify elements of Puppet Module spec tests.


## Slide Content - This is the content for the instructional video.

### slide 1 - Testing Puppet: Unit Tests

As your codebase grows in complexity, changing one part of the code without affecting other parts becomes exponentially more difficult. Unit tests are a method for ensuring that individual parts of your codebase continue to work as intended while other parts are improved and refactored as needed. 

### slide 2 - Testing Flow Diagram

This course is one in a series of courses that we have created to help you learn more about testing Puppet code. Earlier course included topics focused on why testing is important, how to validate your Puppet code with puppet parser and puppet lint, and how to write basic smoke tests to verify that your code compiles and cleanly applies to a node.  In this course we move towards more rigorous testing of your Puppet code and modules. Unit testing allows you to check whether your code actually behaves in the manner that you expect. And once you have units working individually, you can move on to methods for testing your complete configuration, such an acceptance testing. 

In this course we look at how to write unit tests for your Puppet modules using the rspec testing library. But first - a brief review of the structure of a Puppet module. 

### slide 3 - Module Review

Modules are self-contained bundles of code and data. On disk, a module is a directory tree with a specific, predictable structure. The module name is the outermost directory’s name. The manifests directory contains all of the manifests in the module, including an `init.pp` manifest where the class name matches the module name. Other manifest file names map to the names of the classes they contain. A well-formed Puppet module implements each class in a separate file in the manifests directory. Although none of the directories in the module tree are mandatory, for the purposes of testing, you should have an examples sub-directory that contains the test examples that you write for smoke testing your class declarations and defined types. And you should have a spec directory where you put spec and server spec tests, including unit tests, that you use to test plugins in the lib directory.
### slide 4 - Why unit tests?

Unit tests let you test parts of a complete configuration, in isolation from one another and in a controlled context, so that you can identify exactly what pieces may be not working and under what conditions.  Your unit tests should be as simple as possible and easy to debug. They should test the smallest unit of functionality and are intended to prove that each part of your code can work on its own as intended and independent of the other pieces.

### slide 5 - What to tests?

Unit tests don't test the results of executing your manifest on a live system. What they do test is the behaviour of Puppet when it compiles your resources into a catalogue. Your unit tests ensure that resources are included and that classes are declared. They also validate the resource attributes and evaluate results with different class parameters.

### slide 6 - How to tests?

Puppet is written in Ruby. And so it works very well to test your Puppet modules with a Ruby tool. In the Ruby world, there are several testing libraries that you can use to test your Puppet modules. rspec is a popular one and one that we use extensively at Puppet Labs. Rspec-Puppet provides a unit-testing framework for Puppet. It extends RSpec to allow the testing framework to understand Puppet catalogs, the artifact it specializes in testing. With rspec-puppet, you can write tests to test that aspects of your module work as intended.

### slide 7 - Simple Tests

At first glance, it could appear that writing unit tests is nothing more than duplicating manifests in another language.  And that may be true for simple manifests. 

### slide 8 - Template in the test

However, when you start to write more complex modules, that include dynamic content from templates, support multiple operating systems, or that take different actions when passed parameters, unit tests are invaluable. And when you add new functionality to your modules, unit tests can help protect against regressions when refactoring or upgrading to a new Puppet release.

### slide 9 Test-Driven Development

Before we look at how to create tests with rspec-puppet, there are some concepts that you should be familiar with. Test-Driven Development is a practice that involves writing tests before writing the code that you are going to test. You begin by writing a very small test for code that does not yet exist. You run the test, and of course it fails. Then you write just enough code to make the test pass.  rspec was created in 2005 by Steven Baker from the idea that with languages such as Ruby, he could more freely explore new test driven development frameworks that could encourage focus on behaviour instead of structure.  Although the syntax has changed over time, the basic premise remains the same. You can use rspec to write executable examples of the expected behavior of a small bit of code in a controlled context. In your environment, you likely already have modules written that you want to test. And for the purposes of this course, we use examples from tests and modules that are already written. 

### slide 10 - rspec Matchers

Next, and before we look at how to create tests with rspec-puppet, it is important to be familiar with rspec matchers. For the purpose of validating conditions, rspec matchers can match exact values, regular expresssions, or Ruby Procs. Let's look at some methods for validating some conditions.

### slide 11 - Catalog compiles

First you may want to test whether a catalog compiles cleanly; you can use the matcher "compile." And if you want to see raised error messages, you can use the should compile matcher with the and raise error extension and the error message that you want to see. In this example, we are checking for an error message that indicates that the apache module does not run on Windows.

### slide 12 - Catalog Resources

You'll also want to check that the catalog contains resources. To check whether a resource exists you use the contain matcher and the resource type for each resource type and helper that (you want to test for. This example  example is checking to see whether an s s h service has been declared.

### slide 13 - Specified Resource Attributes

To validate that resources have specified attributes, you use the contain matcher and the resource type and add the with or without chains and the attribute that you want to check for. In the first example we are checking tfor a file with a specific owner, root. And in the second example we are checking for a file that has the mode attribute undefined.

### slide 14 - Resource relationships

You can also use matchers to validate that resources have relationships set. You can test the relationships between the resources in your catalog regardless of how the jrelationship is defined. IN otherwords, you can define relationships with the metaparameters require, before, notify, and subscrioe, or with chaining arrows. Once again you use the should contain type matcher and add the relationship matcher

### slide 15 - Matcher Shortcuts

You can also combine matchers. This example shows how you can use chaining to create shortcuts. 

### slide 16 - Puppet Module Generate

So now let's say that you have used puppet module generate to create  your module structure for you. Puppet creates the directories, and the appropriate files in those directories, that you need for testing . 

### Slide 17 - Testing Directory Tree

This is a recommended directory structure and naming conventions for purposes of testing your module. Although none of the sub-directories are required, these are some sample group directories. If you use this structure, your examples will be placed in the correct groups automatically and will have access to the custom matchers. However, if you choose not to use this structure, you can force the examples into the required groups with syntax such as this to test a class.

### slide 18 - Install rspec-puppet

If you used the Puppet module generate to create your module, Puppet automatically created spec directory for you. However, you still need to install the Ruby gems. To install the rspec-puppet gem, type the command `/opt/puppet/bin/gem install rspec-puppet`. Then, to set up tests, install the puppetlabs_spec_helper gem. Type the command `/opt/puppet/bin/gem install puppetlabs_spec_helper`. You may notice that we use Puppet's vendored Ruby, instead of the system Ruby, to install. Although not always the best practice, it happens to be the simplest method of making the proper libraries and gems available for rpsec-puppet to load. You should only install a gem into Puppet's vendoored path if that gem needs to work with Puppet in some way. 

### slide 19 - Sandbox files

rspec rspec-puppet needs three files in order to run your tests. If you use Puppet Module Generate to create your module, Puppet creates the Rakefile and the spec_helper file. .fixtures.yml is a file used exclusively by rspec to pull in dependencies required to successfully run unit tests. rspec compiles Puppet catalogs in a sandbox. It needs a minimal environment, including a module path. the fixture dot yml file creates the modulepath for the sandbox. You need to create the fixture dot yml file, and include in it  symlinks for all the modules that the module you are testing depends on. 
### slide 20 - Structure of spec-puppet Tests
So, now that rspec-puppet is installed and we've looked at the basic rpec-puppet concepts, the recommended directory tree structure for testing your modules, and the required files, let's look more specifically at writing rspec-puppet tests. Regardless of whether you are testing classes, defined types, functions, or hosts, the basic structure of your test file is the same. You want to include the spec_helper  library of functions for running your tests. The basic structure of describing the thing you want to test  and what the test should do lets you easily express concepts in a conversational manner.
 
## Exercises

## Quiz

## References


------
------

