# Puppet Smoke Testing

After basic code validation, the next level of testing is smoke testing.
The goal of smoke testing is to verify that your module runs and does what you want it to do.  

At the end of this course you will be able to:

* Build a module directory for testing
* Write smoke tests
* Run smoke tests 

# Slide Content

## This is the content for the instructional video.


### slide 1-  Title - Puppet Module Smoke Testing

### slide 2 - Smoking Computer

The term "smoke testing," was coined when smoke was introduced to check for leaks in newly manufactured containers and pipes.  In terms of electronics, smoke-testing originally explained how engineers checked to see if their gadgets worked; plug it in and if smoke comes out ... well, it doesn't work. the Term has evolved to also refer to the first level of testing for a software application or program. 

### slide 3 -  Testing Flow

Smoke tests exist to check basic functionalities and should be a consistent part of your testing process. Doing some basic “Does it explode? Is there any smoke?” testing on your Puppet modules is very simple, has obvious benefits during development, and can serve as a condensed form of documentation. In the Validating your Puppet Code online course, we presented several tools to help you write and check your code - the Puppet Language Style Guide, Puppet parser, and puppet lint. After code validation, Smoke testing is the first level of testing that you perform to simply verify that your module runs. You conduct these tests before more rigorous functionality testing.

### slide 4 - Review of Concepts

Before talking more about testing modules, let's do a quick review of some Puppet concepts ... Puppet resources are building blocks. Each resource represents a single configuration item on the managed system, such as a package, a service, or a file. A class is a named block of code that includes and defines the state of a group of resources. Manifests are the files that include your Puppet code; they end in a .pp extension. And a Puppet module contains all of the code and data required to manage a single aspect of your machines.  For example, you could have a module to configure and manage the IIS webserver, and a module to configure and manage a MySQL server or client.  

### slide 5 - Define vs. declare

One last reminder about classes ... Defining a class is similar to defining a function in another language like Ruby. The function only has effect when it is invoked. Similarly, Puppet class definitions don't have any effect until we declare them. When you build a class, you are defining it. But defining a class does not automatically add it to a configuration. To use the class, you need to declare it, and one way to declare a class is with the include function. Declaring the class instructs Puppet to evaluate and enforce it. 

### slide 6 - Module directory review

A Puppet module directory tree has a specific, predictable structure.  With Puppet Enterprise, the main module directory path for users is etc puppetlabs puppet modules. The module name is the outermost directory’s name. The module directory has a manifests sub-directory which contains all of the manifests in the module. The manifests subdirectory should include an init.pp manifest that contains a definition for a class with the same name as the module. Other manifest file names map to the names of the classes they contain. A well-formed Puppet module implements each class in a separate file in the manifests directory. Although none of the directories in the module tree are mandatory, for the purposes of smoke testing, you should have an examples sub-directory that contains the test examples that you write for smoke testing your class declarations and defined types. 

### slide 7 - Module Smoke testing

The baseline for module testing used by Puppet Labs is that each manifest should have a corresponding test manifest, included in the examples directory,  that declares that class. As a best practice, Puppet recommends that you write your smoke test examples as you are developing your module. In this way you can complete ad hoc testing  as you develop. As you can see, if you create a test for each class, you will have an examples directory that is a mirror image of the manifests directory.  


### slide 8 - Sample module tree

In this sample module directory, s s h is the name of the module. There are two Puppet manifests in the manifests directory,  and in the examples directory there is a test for each manifest. The init dot p p manifest defines the s s h class; and the init.pp test declares it. The server manifest defines the s s h  server class; and the server.pp test declares it. A test for a class is really just a manifest that declares the class. So - when you perform smoke testing on your puppet modules, you are testing your class declarations. Often, this is as simple as shown in our example, one line that says include s s h.


### slide 9 - puppet apply and puppet apply --noop

To smoke test your manifests, you can run puppet apply --noop and puppet apply against the files in the examples directory. The puppet apply command in --noop mode informs you, before making any changes, of system drift and expected convergence actions that Puppet will make when you choose to execute them.  Based on the output, you may want to edit your manifest or files before running puppet apply. The puppet apply command compiles a manifest and enforces it immediately. This is an ad hoc verification or proof of concept to see how the module will manage the system once you implement it. When you apply a smoke test, you are enforcing the class in the manifest that you specify, locally and one time only; the configuration isn't permanent. The changes will be overridden on the next agent run. 

You want to be sure to run puppet apply against the files in the examples directory, and not those in the manifests directory. Files in the manifests directory contain the classes with the resource definitions, but to implement the resources, you need to declare the classes.  And the files in the examples directory contain the declarations, which will actually initiate action. There is no harm in running puppet apply against files in the manifests directory, but this will not apply any changes.

### slide 10 - puppet apply --noop output

So, to test the s s h class from our previous example, from within the s s h modules directory, first enter the command puppet apply --noop examples forward slash init dot p p. You receive output that looks something like this. Puppet compiles the catalog. But then, instead of executing any changes, Puppet provides Notice of the state that should exist and of  changes that would have happened if you had run puppet apply without noop. You can also see that noop is indicated after the staged changes.

### slide 11 - puppet apply output

If the output from puppet apply noop indicates that the convergence actions are what you want, you can run puppet apply without noop to enforce the change in state. For our s s h modules example, you might receive output that looks something like this. In this example, the output informs you that Puppet has compiled the catalog and executed the changes. Remember, when you apply a smoke test, you are enforcing the class in the manifest that you specify, locally and one time only. The changes will be overridden on the next agent run.  

### slide 12 - Summary

Although smoke testing is only the most basic level of testing, it allows you to verify that your code compiles and cleanly applies to a node. If nothing blows up, then you are ready to proceed to more rigorous testing of your modules before placing them into production. The next course in this testing bundle introduces unit testing for your Puppet modules.

### slide 13 - Next steps

Before moving on to the next level of testing, check your knowledge of smoke testing by completing the short quiz that appears on the page below this video. If you want, you can launch the V M that we have provided for you and practice applying smoke tests.





##Exercise

When you smoke test your Puppet code, you are validating that the code compiles by enforcing a a class one time only, locally. You can run the puppet apply --noop and puppet apply commands against tests files in the examples directory to smoke test your puppet code.

In this exercise, you can practice validating the puppet code in and applying smoke tests to the ssh module that we have created for you in /etc/puppetlabs/code/modules.

1. Click on the Practice VM icon and log in to the virtual machine that we have set up for your practice session. The login and password display on the welcome screen.

2. Change directory to `/etc/puppetlabs/code/modules/ssh` directory and list the contents to see the sub-directories it contains.

3. Run puppet parser on each of the files in the manifests directory. Edit the files to correct any errors, and then re-run the command. For example:

`puppet parser validate /etc/puppetlabs/code/modules/ssh/manifests/init.pp`

4. Run puppet lint on the init.pp manifiest. Again, edit the manifest to correct any errors.

puppet-lint /etc/puppetlabs/puppet/modules/ssh/manifests/init.pp

5. After you have fixed any errors, you still may receive warnings, such as: 

`WARNING: class inheriting from params class on line  6`

This is a warning from puppet lint just to call out that you are inheriting parameterized classes. To ignore the warning, re-run puppet lint with the ignore flag.

`puppet-lint --no-class_inherits_from_params_class-check examples/init.pp` 

6. Run `puppet apply --noop` on each of the files in the examples directory. If you encounter any errors, correct them and then re-run the command.

7. Run `puppet apply` on each of the files in the examples directory.
    

## Quiz    
   
 Included in the online course file.
