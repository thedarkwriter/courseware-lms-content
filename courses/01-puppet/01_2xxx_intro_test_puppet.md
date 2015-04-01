# Why test your Puppet code?

Testing is key to releasing high quality software. And testing can actually save you time. Early and frequent testing helps to catch defects early in the development cycle, preventing them from becoming expensive and endemic problems. Eliminating defects early in the process usually means you avoid lengthy and tedious debugging later in the project. And automating your tests ensures that testing is repeatable, reliable, and fast. 

At the end of this course you will be able to:

* State reasons that you should test your Puppet code.
* Identify testing methods recommended by Puppet.

## Slide Content

### slide - Title

One of the issues that crops up when working with Puppet is ensuring that your manifests do what you expect. Errors are bound to happen. A missed brace can make a manifest not compile, or forgetting to include a module or set a variable may mean that running Puppet on the host fails to enforce the expected state. All in all, it would help to have some tools to make sure we’re writing valid code, that it does what it expects, and that if it doesn’t we identify errors as soon as possible.

### slide Test Courses

This is the first of a series of online courses that we have created to help you learn about how to test your Puppet modules and projects. You can take the courses in any order you choose. However, to get the greatest benefit, we recommend that you take them in the order listed here and in the in the online catalog.

### slide - Automate It

Puppet is about automating the management of your IT infrastructure, large or small, simple or complex. And Puppet is especially concerned with managing the entire life cycle of your infrastructure, fixing or updating configuration files and automatically restarting services. But all of this only works if your modules are written correctly, which proper testing can ensure. We have a number of tools and frameworks available to help you test your modules. But first, a brief review of Puppet's structure and some best practices for writing Puppet modules.

### slide  - 

Let's say you have been writing Puppet modules for a while now. You know what they are supposed to do and what they're not supposed to do. Your modules work well, and you are getting the expected results, with no issues that you know of.  This is all very good, right? 
### slide  Why test?

So then why should you spend your limited, valuable time writing and running tests?  Actually there are some very good reasons.

### slide Reasons to test

Testing your code can help you to:* Confirm that code updates don't break anything, * Ensure platform changes are accounted for,* Avoid committing broken code to your repository, * And help you to maintain good programming practice.


### slide Puppet Approved

Essentially, testing is a basic element of writing a great Puppet module. Whether you are writing a module for internal use only, or for use by a broad audience. Every module should adhere to established standards for coding styles, functionality, and compatibility.  
### slide Workflow

Testing can help ensure that you are on the right path towards your project objectives and that every manifest and module you create adheres to the established standards. Testing while you develop allows for a steady flow of code from the development team out to the user base.


### slide Collaboration

Although you may work independently at times, we all collaborate on common projects. Not only do you want to be sure that your project is on track and that you are adhering to standards, you also want to be sure that what you create works with the rest of the environment. If you don't test, how will you know that changes you make don't affect the operation of existing code? 

### slide Quality

In the end, testing can actually save you time. Early, frequent testing helps you catch defects early in the development cycle, preventing them from becoming expensive and endemic problems. Eliminating defects early in the process usually means you can avoid lengthy and tedious debugging later in the project. Testing is key to releasing high quality software. And by automating your tests, you ensure that testing is repeatable, reliable, and fast.    
 

### slide The "sysadmin" Way

So, testing is important. As a systems administrator, you probably already knew that. But how you test your Puppet code may look and feel a bit different from how you are used to testing changes to your systems.

Typically your testing may include a 'stepping' process. You deploy the code to 2 production machines for a couple days, then 5 machines, and then 10 machines until you roll out the change to the entire set of servers. 

This "sysadmin" method of testing applied to Puppet manifests and modules would be very time consuming. You would have to write the code, build your modules, provision a test server, apply the manifests, and watch for errors. If you encountered errors, you would fix them, then redeploy a test server, and re-run the tests. And you still could not be certain that the module would run on other types servers. 

### slide Test Driven Development

However, by utilizing methods from the development world, you can simplify the testing cycle, as well as automate and categorize it. You can even create multiple tests to validate the same set of manifests against different types of servers.

### slide Primary Testing

Puppet Labs relies heavily on automated testing to ensure that Puppet behaves as expected and that new features don't interfere with existing behavior.  Beyond code validation and smoke testing, there are three primary sets of tests that Puppet uses. Unit tests are used to test the individual components of Puppet to ensure that they function as expected in isolation. Integration tests are used to test different units of code together to ensure that they interact correctly.  And acceptance tests are used to test high level behaviors of Puppet that deal with a number of concerns and that aren't easily tested with normal unit tests.

### slide Humans

Humans make mistakes. Some mistakes are unimportant, but some are expensive or dangerous. We need to check everything and anything we produce because errors are bound to happen. So, it would help to have some tools to make sure you are writing valid code, that the code does what is expected, and that if it doesn’t behave as expected, you identify errors as soon as possible. 


### slide List of Testing Classes

We have created a whole series of online Puppet Labs classes to help you learn about some tools and techniques for testing your Puppet modules and projects. Although you can take the classes in any order, to gain the greatest benefits, we recommend completing them in the order listed here and in the online catalog.

### slide Next Steps

To check your knowledge, click the link on the bottom of this course's page and complete the short quiz. There is also a link to additional learning resources.


### slide Thank you

------
------

## Exercises

## Quiz

## References