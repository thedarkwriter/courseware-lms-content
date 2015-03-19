# Why test your Puppet code?

Testing is key to releasing high quality software. And automating your tests ensures that testing is repeatable, reliable, and fast.  

At the end of this course you will be able to:

* explain 
* create 
* examine 



## Slide Content

### slide 1 - Title
#### Introduction to Testing Puppet Code

So, let's say you have been writing Puppet modules for a while now. You know what they are supposed to do and  what they're not supposed to do. Your modules work well, and you are getting the expected result, with no issues that you know of.  This is all very good, right? 

### slide  Why test?

So why should you spend your limited, valuable time writing and running tests?  Well, actually there are some good reasons.

### slide Humans

Testing is necessary because ... well, we all make mistakes. Some mistakes are unimportant, but some are expensive or dangerous. We need to check  everything and anything we produce because errors are bound to happen. 

### slide Puppet Approved

Essentially, testing is a basic element of writing a great Puppet module. Whether you are writing a module for internal use only, or for use by a broad audience. Every module should adhere to established standards for coding styles, functionality, and compatibility.  

Testing your code lets you:

* Confirm that code updates don't break anything.
* Ensure that platform changes are accounted for.
* Avoid committing broken code to your repository.
* Helps maintain good programming practice.


### slide Workflow

Test-driven development can help ensure that you are on the right path towards your project objectives and that every manifest and module you create adheres to the established standards. Testing while you develop allows for a steady flow of code from the development team out to the user base. .


### slide Collaboration

Although you may work independently on some projects, sooner or later we all collaborate on common projects. No only do you want to be sure that your project is on track and that you are adhering to standards, you also want to be sure that what you create works with the rest of the environment. And you want to be certain that what you contribute does not break or harm anyone else's code.

If you don't test, how will know know that changes you make don't affect the proper operation of existing code? This role of tests — to act as sensors and monitors throughout the code base — is one of the most compelling arguments for their use.

### slide Quality

In the end, testing can actually save you time.  Early and frequent testing helps to catch defects early in the development cycle, preventing them from becoming endemic and expensive problems. Eliminating defects early in the process usually avoids lengthy and tedious debugging later in the project.

Testing is key to releasing high quality software. And automating your tests ensures that testing is repeatable, reliable, and fast.  


### slide Test Driven Development

So, testing is important. As a systems administrator, you probably already knew that. But how you test your Puppet code may look and feel a bit different from how you test changes to your systems.

As a system administrator, your testing process has probably included setting up a test server, making configuration changes to the test server, and verifying that those changes are good - that is, they are appropriate, do what you want, don't do anything unexpected, and don't cause harm - before deploying them to the production environment. 

This type of  "sysadmin" method of testing applied to Puppet manifests and modules would be very time time consuming. You would have to write the code, build your modules, provision a test server, apply the manifests, and watch for errors. If there were errors, you would fix the errors and then redeploy a test server, and re-run the tests. And you still could not be certain that the module would run on other types servers. 

By utilizing methods from the development world, you can simplify the testing cycle, as well as automate and categorize it. You can even create multiple tests to validate the same set of manifests against different types of servers.

### slide Puppet Automates

Puppet is about automating the management of IT infrastructure, large or small, simple or complex. Based on your requirements, you just may need to install a package or configure a service. Puppet is especially concerned with managing the entire life cycle of your infrastructure, fixing or updating configuration files and automatically restarting services. But all this only works if your modules are written correctly, which proper testing can ensure.

So, all in all, it would help to have some tools to make sure you are writing valid code, that it does what it expects, and that if it doesn’t you catch it as soon as possible. 



### slide What and When
So, what kind of testing should you do and when should you test?


### slide Testing at Puppet

Puppet Labs relies heavily on automated testing to ensure that Puppet behaves as expected and that new features don't interfere with existing behavior. And we have a number of tools and frameworks available to help you to write and test your modules. 

There are three primary sets of tests that Puppet uses: unit tests, integration tests, and acceptance tests.

Unit tests are used to test the individual components of Puppet to ensure that they function as expected in isolation. 

Integration tests serve to test different units of code together to ensure that they interact correctly. 

Acceptance tests are used to test high level behaviors of Puppet that deal with a number of concerns and aren't easily tested with normal unit tests. 

### slide

We have created a whole series of online Puppet Labs Workshop classes that you can work through to learn all about how to test your Puppet modules and projects. Although you can take the classes in any order you choose, we recommend completing them in this order.

------
------

## Exercises

## Quiz

## References