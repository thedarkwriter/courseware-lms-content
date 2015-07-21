# Testing Puppet: Unit Tests

Understanding ....  

At the end of this course you will be able to:

* explain 
* create 
* examine 

## Video

## Exercises

## Quiz

## References

# Slide Content
## This is the content for the instructional video.



### slide 1 - Testing Puppet: Unit Tests

Unit tests let you test parts of a complete configuration, in isolation from one another and in a controlled context, so that you can identify exactly what pieces may be not working and under what conditions.  Your unit tests should be as simple as possible and easy to debug. They should test the smallest unit of functionality and are intended to prove that each part of your code can work on its own as intended and independent of the other pieces.

### slide 2 - Testing Flow Diagram

This course is one in a series of courses that we have created to help you learn more about testing Puppet code. Earlier course included topics focused on why testing is important, how to validate your Puppet code with puppet parser and puppet lint, and how to write basic smoke tests to verify that your code compiles and cleanly applies to a node.  In this course we move towards more rigorous testing of your Puppet code and modules. Unit testing allows you to check whether your code actually behaves in the manner that you expect. And once you have units working individually, you can move on to methods for testing your complete configuration, such an acceptance testing. 

In this course we look at how to write unit tests for your Puppet modules using the rspec testing library. But first - a brief review of the structure of a Puppet module. 

### slide 2 - Module Review

Modules are self-contained bundles of code and data. On disk, a module is a directory tree with a specific, predictable structure. The module name is the outermost directory’s name. The manifests directory contains all of the manifests in the module, including an `init.pp` manifest where the class name matches the module name. Other manifest file names map to the names of the classes they contain. A well-formed Puppet module implements each class in a separate file in the manifests directory. Although none of the directories in the module tree are mandatory, for the purposes of testing, you should have an examples sub-directory that contains the test examples that you write for smoke testing your class declarations and defined types. And you should have a spec directory where you put spec and server spec tests, including unit tests, that you use to test plugins in the lib directory.



------
------

