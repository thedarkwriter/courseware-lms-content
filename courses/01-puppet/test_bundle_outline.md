# Testing Puppet Bundle

## Assumptions

* You know how to write modules
* You have Puppet or Puppet Enterprise installed

Setup for online classes:
- need to have a directory structure in place


## Bundle 1 - Why test?

* Because
* Kinds of tests
    * Code Validation
    * Unit
    * Acceptance
* Puppet Testing
    * How we do it here
    * Some tools we use
* When to write your tests? Before or while you are writing your modules.
* Testing workflow
* Review of the module directory structure
    * These are the rules to be followed with the directory structure:

        * The directories should be named correctly (*manifests* not *manifest*).
        * The `init.pp` manifest should contain a definition for a class with the
  same name as the module.
        * None of the directories in the Module tree are *mandatory* - include only
  what you need.
        * Files in the `tests` directory should allow for smoke testing
  corresponding files in the `manifests` directory.


From Practitioner/Intro to Testing/Lab-rspec_puppet.md:

Writing solid modules that work reliably in a representative testing environment
is only one step of many. Also needed is a way of validating that the modules
work across multiple platforms and under all possible conditions. An even bigger
problem is that of maintainability.

As a codebase grows in complexity it becomes exponentially difficult to change
one part of the code without affecting other parts. Clearly a method for ensuring
that all these parts continue to work as other parts of the codebase are improved
and refactored is needed. We address this with _unit tests_.

A unit test is designed to test small parts of a complete configuration and to
test them in isolation from one another. That helps us to identify exactly what
pieces have broken and under what conditions. Problems in one class are identified
before being conflated with all the other classes in a complete catalog, allowing
us to look at it with pinpoint precision, rather than attempting to backtrack
through a complete debug log.

    
## Bundle 2 - Testing your code

* review of module directory structure -  
`manifests`:
    * Contains definitions for classes and defined types
    * Contain the `.pp` extension
`tests`:
    * Smoke tests for the code in the `manifests` directory
    * Named after the corresponding manifests
`lib`:
    * Plugins and Extensions that add custom features to Puppet
    * These need to be within an appropriate directory structure
    * Directory structure mirrors Puppet's lib directory
`files`:
    * Contains **static** files to be used as the content for managed files
    * Configuration files etc can be served from the Puppet master
    * Default Puppet file server used to serve these files
`templates`:
    * Files containing Embedded Ruby (ERB) code
    * These can be evaluated to return content
    * Using .erb for the extension makes it clear that they are templates
`spec`:
    * Unit and Acceptance tests for the module

* puppet module skeleton (and other tools)
    * installation 
    * talk about the directory structure
* Code Validation - a little more detail
* Writing code and tests at the same time - thinking behind it and why do it that way
* Puppet Style Guide and puppet-lint as the enforcer
* puppet parser validate

--noop? smoke tests? where do these fit in? (see writing your first module declaring section)


## Bundle 3 - Unit Testing your Puppet Code

* (This the rspec bundle)
* Practitioner - Introduction to Module testing/rspec_puppet.md, rspec_matchers.md
* 

To get a quick overview of the `rspec-puppet` test framework, see the tutorial at
[http://rspec-puppet.com/tutorial/](http://rspec-puppet.com/tutorial/). This will
teach you how to write simple unit tests for your modules and might be all you ever
need to read.

Remember that you do not need to run `rspec-puppet-init` when using
`puppetlabs_spec_helper`.

If you'd like to understand the underlying RSpec test framework better or if you
would like to learn how to write unit tests for Ruby projects, you may study the
documentation located at [https://www.relishapp.com/rspec](https://www.relishapp.com/rspec).

* Why unit test? (module testing)
    * Does this just duplicate manifests in another language?
        * Only for simple manifests.
    * Tests are invaluable when your manifests:
        * Include dynamic content from templates. (such as?)
        * Support multiple operating systems. 
        * Take different actions when passed parameters.(for example? and are the actions different based on the different parameters, or different from something else when passed any parameter?)
    * Unit tests help you to:
        * Protect against regressions when refactoring. (For example?)
        * Trust that major Puppet and module upgrades will be ???
* What should you be testing with your unit tests?
    * Unit tests do not test the result on a live system.
    * Test the behavior of Puppet catalog compilations to:
        * Ensure that resources are included.
        * Ensure that classes are declared.
        * Validate resource attributes.
        * Evaluate with different class parameters.
* What is rspec? 
    * ruby syntax basically - for structured testing
    * and a framwork for testing Ruby classes
* And What is rspec-puppet?
    * Puppet is written in Ruby - so we created rspec-puppet
    * adds puppet stuff (services, packages) so that we can test puppet
    * generates and checks puppet catalogs
    * checks that the catalog contains the values that we want saved (e.g., an http pkg)
    * inspects what is there
 * Install ... (Practitioner - Introduction to Module Testing/rpec_setup.md)(There is a note that the way we install in the class is not the cleanest way. So should we be teaching a different way?)
    * gem install rspec-puppet
    * gem install puppetlabs_spec_helper
    * gem install rake
 * Configure ... (Practitioner - Introduction to Module Testing/rpec_setup.md, rspec_files.md)
    * rspec-puppet
    * puppetlabs_spec_helper (Remember that you do not need to run `rspec-puppet-init` when using `puppetlabs_spec_helper`.)
    * rake
 * Unit Testing - even if the syntax and style are correct - does mean the code is going to do what you want it to do. Design, write your tests while you are writing your modules.
    * Writing
    * Running
    * When a test fails, what do you do?
    
Unit Test a class - Lab-rspec_puppet.md Includes a good practice example and solution.
    
## Bundle 4 - Acceptance Testing

Unit tests to validate each individual class under controlled conditions are great, but we should also ensure that the final result is a node configured to meet requirements. Validating that the catalog compiles and includes all the resources expected is of limited usefulness if a managed configuration file has invalid syntax or if the package name passed to the package manager is incorrect.

Serverspec is a configuration management agnostic tool that doesn't concern itself with the tools used to configure the machine and instead just validates the end result. It can make sure that a certain service is running, that named users exist, that the machine is listening on the proper ports and responds with the correct response headers, and many other things. In other words, it doesn't validate the configuration of a machine, but the behaviour of that machine.

acceptance_test.md
Validate that the end result meets the need

* Service installed and running
* Configuration file:
    *  Exists
    * Contains expected settings
* Listening on port 
    
Now we know that the pieces are right - we did that in Unit testing - next step is to see whether thay all work together. And we have some tools for that. Let's take a look at some of them before we get into writing some acceptance tests.

* Venn diagram
    * respec
    * serverspec
    * beaker
    * beaker-rspec is the Puppet tool to do acceptance testing
    * as we know now - rspec is the Ruby blah blah blah
    * serverspec uses rspec syntax
        * after puppet code is executed, checks return values, 
        * inspects the end state
        * one one machine, locally
    * beaker lets you do the acceptance testing on multiple machines
        * provisioning
* Acceptance testing on a single machine, locally (use Practitioner materials)
    * serverspec
    serverspec.md:
    serverspec_example.md
    * install
    * configure
    * what to do when your test fails
    
Acceptance test a server - Lab-serverspec.md
    
* beaker-rspec (single or multiple test hosts that are not your local machine)
     * install
     * configure
         * create systems under test (SUTs) - puppet labs available boxes
     * Provisioning
         * Vagrant - free - 
         * Install
         * configure (puppet boxes)
         
 * Beaker-rspec testing
     * reminder, review of acceptance testing and what beaker-rspec does for you
     * writing
     * running
     * what to do when your test fails. My test failed - now what?