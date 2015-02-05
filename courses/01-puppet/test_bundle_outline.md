# Testing Puppet Bundle

## Assumptions

* You know how to write modules
* You have Puppet or Puppet Enterprise installed

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
    
## Bundle 2 - Testing your code

* puppet module skeleton (and other tools)
    * installation 
    * talk about the directory structure
* Code Validation - a little more detail
* Writing code and tests at the same time - thinking behind it and why do it that way
* Puppet Style Guide and puppet-lint as the enforcer
* puppet parser validate

## Bundle 3 - Unit Testing your Puppet Code

* (This the rspec bundle)
* What is rspec? 
    * ruby syntax basically - for structured testing
    * and a framwork for testing Ruby classes
* And What is rspec-puppet?
    * Puppet is written in Ruby - so we created rspec-puppet
    * adds puppet stuff (services, packages) so that we can test puppet
    * generates and checks puppet catalogs
    * checks that the catalog contains the values that we want saved (e.g., an http pkg)
    * inspects what is there
 * Install ... 
    * gem install rspec-puppet
    * gem install puppetlabs_spec_helper
    * gem install rake
 * Configure ... 
    * rspec-puppet
    * puppetlabs_spec_helper
    * rake
 * Unit Testing - even if the syntax and style are correct - does mean the code is going to do what you want it to do. Design, write your tests while you are writing your modules.
    * Writing
    * Running
    * When a test fails, what do you do?
    
## Bundle 4 - Acceptance Testing
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
* Acceptance testing on a single machine, locally
    * serverspec
    * install
    * configure
    * what to do when your test fails
 * beaker-rspec
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