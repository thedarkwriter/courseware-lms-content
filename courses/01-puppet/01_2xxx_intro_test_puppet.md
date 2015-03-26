# Why test your Puppet code?

Testing is key to releasing high quality software. And automating your tests ensures that testing is repeatable, reliable, and fast.  

At the end of this course you will be able to:

* State reasons that you should test your Puppet code.
* Identify testing methods recommended by Puppet.
* Describe the Puppet module testing directories.

## Slide Content

### slide 1 - Title

Let's say you have been writing Puppet modules for a while now. You know what they are supposed to do and  what they're not supposed to do. Your modules work well, and you are getting the expected results, with no issues that you know of.  This is all very good, right? 
### slide  Why test?

So then why should you spend your limited, valuable time writing and running tests?  Actually there are some very good reasons.

### slide Puppet Approved

Essentially, testing is a basic element of writing a great Puppet module. Whether you are writing a module for internal use only, or for use by a broad audience. Every module should adhere to established standards for coding styles, functionality, and compatibility.  
### slide Workflow

Testing can help ensure that you are on the right path towards your project objectives and that every manifest and module you create adheres to the established standards. Testing while you develop allows for a steady flow of code from the development team out to the user base.


### slide Collaboration

Although you may work independently on some projects, sooner or later we all collaborate on common projects. Not only do you want to be sure that your project is on track and that you are adhering to standards, you also want to be sure that what you create works with the rest of the environment. If you don't test, how will you know that changes you make don't affect the operation of existing code? This role of tests — to act as sensors and monitors throughout the code base — is one of the most compelling arguments for their use.

### slide Quality

In the end, testing can actually save you time.  Early and frequent testing helps to catch defects early in the development cycle, preventing them from becoming expensive and endemic problems. Eliminating defects early in the process usually means you avoid lengthy and tedious debugging later in the project. Testing is key to releasing high quality software. And automating your tests ensures that testing is repeatable, reliable, and fast.    
 

### slide Test Driven Development

So, testing is important. As a systems administrator, you probably already knew that. But how you test your Puppet code may look and feel a bit different from how you are used to testing changes to your systems. Your testing process has probably included setting up a test server, making configuration changes to the test server, and verifying that those changes are appropriate, do what you want, don't do anything unexpected, and don't cause harm - before deploying them to the production environment.  

This "sysadmin" method of testing applied to Puppet manifests and modules would be very time consuming. You would have to write the code, build your modules, provision a test server, apply the manifests, and watch for errors. If you encountered errors, you would fix them, then redeploy a test server, and re-run the tests. And you still could not be certain that the module would run on other types servers. However, by utilizing methods from the development world, you can simplify the testing cycle, as well as automate and categorize it. You can even create multiple tests to validate the same set of manifests against different types of servers.

### slide Primary Testing

Well, then,what kind of testing should you do and when should you test? Puppet Labs relies heavily on automated testing to ensure that Puppet behaves as expected and that new features don't interfere with existing behavior.  Beyond code validation and smoke testing, there are three primary sets of tests that Puppet uses: unit tests, integration tests, and acceptance tests. Unit tests are used to test the individual components of Puppet to ensure that they function as expected in isolation. Integration tests serve to test different units of code together to ensure that they interact correctly. Acceptance tests are used to test high level behaviors of Puppet that deal with a number of concerns and aren't easily tested with normal unit tests.


### slide Puppet Automates

Puppet is about automating the management of your IT infrastructure, large or small, simple or complex. And Puppet is especially concerned with managing the entire life cycle of your infrastructure, fixing or updating configuration files and automatically restarting services. But all this only works if your modules are written correctly, which proper testing can ensure. We have a number of tools and frameworks available to help you test your modules. But before looking more closely at techniques for testing Puppet, first a brief review of Puppet's structure and best module writing practices.

### slide Puppet Structure

First, a couple of reminders about Puppet structure. The core of the Puppet language is the resource declaration. A resource declaration describes a desired state for one resource. Classes are are individual Puppet resources bundled together to define a single idea, and the primary means by which Puppet Enterprise configures nodes.  Manifests are Puppet programs. They are standard text files, and they hold class definitions and other logic for Puppet to use. Manifests are always saved with a dot p p extension.

### slide Puppet Modules

Modules are self-contained bundles of code and data. On disk, a module is a directory tree with a specific, predictable structure. The module name is the outermost directory’s name. The manifests sub-directory contains all of the manifests for the module, including an init.pp manifest. The init.pp manifest must include a class with the same name as the module. 

The manifests directory contains all of the manifests in the module, including an init.pp manifest, that must include a class with the same name as the module. 

There are also two directories you use for your Puppet testing. The tests directory contains examples showing how to declare the module's classes and defined types.  Each class or type should have an example in the tests directory. And the spec directory contains spec tests for any plugins in the lib directory.

### slide Module Paths

With Puppet Enterprise, the modules you use to manage nodes are located in the directory /etc/puppetlabs/puppet/environments/production/modules - including modules installed by Puppet, modules you download from the Puppet Forge, and modules that you create. Puppet Enterprise also installs modules in the /opt/puppet/share/puppet/modules directory. You should not modify anything in or add any modules to this directory.

### slide Writing Puppet Modules

And now a quick review of best practices for writing your Puppet modules. To write your modules, we strongly suggest that you run the command:  puppet, module, generate, the username for the author, a hyphen, and the module name. When you run the puppet module generate command, the Puppet module tool runs a series of questions to gather metadata about your module and creates a basic module structure for you, including your spec and tests directories and the appropriate files in those  directories.

### slide Example

This is an example of the messaging Puppet gives you after you run the puppet generate module command to create a module. 

### slide Humans

Humans make mistakes. Some mistakes are unimportant, but some are expensive or dangerous. We need to check everything and anything we produce because errors are bound to happen. So, all in all, it would help to have some tools to make sure you are writing valid code, that it does what it expects, and that if it doesn’t you catch it as soon as possible. 

### slide List of Testing Classes

We have created a whole series of online Puppet Labs Workshop classes to help you learn about some tools we have and how to test your Puppet modules and projects.
Although you can take the classes in any order you choose, to gain the greatest benefits, we recommend completing them in the order listed in the online catalog and in this training bundle.

### slide Next Steps

To check your knowledge, click the link on the bottom of this course's page and complete the short quiz. There is also a link to additional learning resources.


### slide Thank you

------
------

## Exercises

## Quiz

## References