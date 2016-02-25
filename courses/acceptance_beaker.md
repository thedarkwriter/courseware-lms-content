# Unit Testing with rspec

Understanding Resources is fundemental to understanding how Puppet works. Resources are like building blocks (think Lego). They can be combined to model the expected state of the systems you manage.  

At the end of this course you will be able to:

* explain what a Puppet resource is.
* create a Puppet resource using proper syntax.
* examine resources using the `puppet resource` tool.

## Video

## Exercises

## Quiz

## References

# Slide Content
## This is the content for the instructional video.

### slide 1
(Course Title - no script) 

### slide 2 Introductory stuff
"Puppet is written in Ruby. And so it works very well to test your Puppet modules with a Ruby tool. In the Ruby world, there are several testing libraries that you can use to test your Puppet modules. rspec is a popular one and one that we use extensively at Puppet Labs."  


### slide 3
Everything is great! Right? So why spend your valuable time testing? Well, for a few reasons."

### slide 
If you don't test, how will know know that changes you make don't affect the proper operation of existing code? This role of tests — to act as sensors and monitors throughout the code base — is probably the most compelling argument for their use.


### slide Reasons
quality assurance

Like with all products, certain quality measurements should be in place for software products.  It does not matter if the modules are 'just' for internal use, for community sharing,  or for sales to external customers.  Every piece of software should adhere to coding styles, functionality, and compatibility.

### slide 
collaboration

It might well be that you are a ‘code warrior’ on your own, writing your own pieces of software for various reasons, and never expect to be working with other people. The truth is though, sooner or later we all participate in collaboration, one way or the other.  If you work on common projects with other developers,  you really do not want somebody else’s code to break yours and undo your work. Neither should your code do this to other developers work, and as such your code needs to adhere to certain standards.


### slide 

documentation

Even though documentation is usually not the favourite part of many software developers, a certain level is required.  Be it some overview about the general functionality, a list of dependencies,  or release notes, documentation is required, period.  Some testing mechanisms can actually produce documentation on the fly, so that is actually good news, init?


### slide 

improved workflow

Some projects start off with the infamous ‘note on a napkin’, possibly developed in the pub or at the cafeteria over lunch.  From here, one can just start wildly putting code together to get started, and then make up a plan on the way. Another way would be to take the time and define clear objectives, requirements, milestones,  and the measurements to verify if these objectives etc. have been reached.
 
One way of  doing the latter is via test-driven development.  It certainly does seem to create a lot of additional work at the beginning, by creating all the tests first before the actual coding starts. Well, actually defining the tests is already including quite some   coding. But this time spent pays off big time later, when continuous tests actually ensure you are always on the right path, and every piece of software produced adheres to required standards.


### slide 

improved infrastructure stability

Puppet in particular is really about automating the management of  IT infrastructure. Depending on your requirements, it may just install a package and configure a service. But it can do much more, in fact the true power of the likes of Puppet, Chef, Saltstack etc. is about the entire life cycle, including and especially about maintenance. Configuration files are fixed or updated and services are restarted automatically.  This way, very large and complex infrastructures can be managed by very small teams easily.  But this all only works if the modules are written correctly, and proper testing will ensure this.


### slide What and When
So, what kind of testing should you do and when should you test?


### slide Testing at Puppet
A brief introduction to testing in Puppet

Puppet relies heavily on automated testing to ensure that Puppet behaves as expected and that new features don't interfere with existing behavior. There are three primary sets of tests that Puppet uses: unit tests, integration tests, and acceptance tests.

Unit tests are used to test the individual components of Puppet to ensure that they function as expected in isolation. Unit tests are designed to hide the actual system implementations and provide canned information so that only the intended behavior is tested, rather than the targeted code and everything else connected to it. Unit tests should never affect the state of the system that's running the test.

Integration tests serve to test different units of code together to ensure that they interact correctly. While individual methods might perform correctly, when used with the rest of the system they might fail, so integration tests are a higher level version of unit tests that serve to check the behavior of individual subsystems.

All of the unit and integration tests for Puppet are kept in the spec/ directory.

Acceptance tests are used to test high level behaviors of Puppet that deal with a number of concerns and aren't easily tested with normal unit tests. Acceptance tests function by changing system state and checking the system after the fact to make sure that the intended behavior occurred. Because of this acceptance tests can be destructive, so the systems being tested should be throwaway systems.




------
------

## References
* [puppet-lint - GitHub](https://github.com/rodjek/puppet-lint)
* [Verifying Puppet: Checking Syntax and Writing Automated Tests](http://puppetlabs.com/blog/verifying-puppet-checking-syntax-and-writing-automated-tests)
* [Style Guide - Docs](http://docs.puppetlabs.com/guides/style_guide.html)
