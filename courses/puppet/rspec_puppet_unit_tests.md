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



------
------

