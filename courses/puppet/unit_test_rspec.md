# Unit Testing with rspec

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

### slide 1
(Course Title - no script) 

### slide 2 Introductory stuff
"Puppet is written in Ruby. And so it works very well to test your Puppet modules with a Ruby tool. In the Ruby world, there are several testing libraries that you can use to test your Puppet modules. rspec is a popular one and one that we use extensively at Puppet Labs."  


### slide The Basics
You can use rspec to encapsulate what your testing with the `describe` blockn and `content`. IN a general unit testing sense, you use `describe` to describe the behavior of a class. For example:

    @@@Puppet
    describe Hash do
    end

### slide 



### slide 


### slide 


### slide 


### slide 


### slide 


### slide What 


# Unit Testing

## How do you know your code isn't broken?

* You have to know two things:
  1. What should the code do?
  2. What does   the code do?
* How do you answer those questions?
  * You could run the code...every time you make any changes.
  * You need to isolate your code from any other system functions.
* Why not have the computer run the code for you in isolation?


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






------
------

