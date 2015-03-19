# Why test your Puppet code?

Understanding ... systems you manage.  

At the end of this course you will be able to:

* explain 
* create 
* examine 




## Slide Content

### slide 1
"Testing is key to releasing high quality software. and automating your tests ensures that testing is repeatable, reliable, and fast.”

### slide 2 Introductory stuff
"So, let's say that you have been writing Puppet modules for a while now. You know what they are supposed to do, you know what they are not supposed to do. Your modules are working well, and they're doing exactly what you intended. 

"Everything is great! Right? So why spend your valuable, limited time testing?"

Now you must ensure that the module works in a variety of conditions, and that the options and parameters of your module work together to achieve an appropriate end result. 

We, at Puppet, have several testing frameworks available to help you write unit and acceptance tests.

(CAP: a module directory tree animated to build while the narrative runs.)

### slide 3

But first, let's take a few minutes to look a little more closely at software testing. 

Add in here - why would a sys admin even care about software testing - and how might Puppet software tests be different fem other usual sys admin tests.


### slide

Well, for a few reasons. Testing your code lets you:

* Confirm that code updates don't break anything.
* Ensure that platform changes are accounted for.
* Avoid committing broken code to your repository.
* Helps maintain good programming practice.

### slide



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

### slide
Kinds of Tests

Different stakeholders require different tests.
Unit Tests
Test the smallest unit of functionality.
As simple as possible, easy to debug, reliable, etc.
Prove that each part of your code works on its own.
Integration Tests
Combine units and test the entire system.
Validate that all parts work together.
Only test the whole system, not individual parts.
Functional and Acceptance Tests
Compare end result with specification.
Only test end results, not intermediate state



### slide Testing at Puppet
A brief introduction to testing in Puppet

Puppet relies heavily on automated testing to ensure that Puppet behaves as expected and that new features don't interfere with existing behavior. There are three primary sets of tests that Puppet uses: unit tests, integration tests, and acceptance tests.

Unit tests are used to test the individual components of Puppet to ensure that they function as expected in isolation. Unit tests are designed to hide the actual system implementations and provide canned information so that only the intended behavior is tested, rather than the targeted code and everything else connected to it. Unit tests should never affect the state of the system that's running the test.

Integration tests serve to test different units of code together to ensure that they interact correctly. While individual methods might perform correctly, when used with the rest of the system they might fail, so integration tests are a higher level version of unit tests that serve to check the behavior of individual subsystems.


Acceptance tests are used to test high level behaviors of Puppet that deal with a number of concerns and aren't easily tested with normal unit tests. Acceptance tests function by changing system state and checking the system after the fact to make sure that the intended behavior occurred. Because of this acceptance tests can be destructive, so the systems being tested should be throwaway systems.


### slide

A next steps and wrap up kind of slide.

We have created a whole series of online Puppet Labs Workshop classes that you can work through to learn all about how to test your Puppet modules and projects. Although you can take the classes in any order you choose, we recommend completing them in this order.

------
------

## Exercises

## Quiz

## References