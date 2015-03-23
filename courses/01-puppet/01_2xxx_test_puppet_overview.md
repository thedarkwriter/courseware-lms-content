# Testing Puppet: An Overview 

Descriptive statement about the course.  

At the end of this course you will be able to:

* explain 
* create 
* examine 


# Slide Content
## This is the content for the instructional video





Ryan:
writing great Puppet modules. I'll try to sum it up in a few sentences:

Your module should be immediately useful to me after I install it. Documentation should be complete and the code itself should adhere to the community style guide. If I need to modify the behavior of your module, you should provide me an interface to do it so I don't have to modify your modules manifests. If I contribute features or bug fixes, I expect you to explain the process and collaborate with me on improving the module.

writing great modules is all about giving you the knowledge and tools to make your module more reusable, immediately useful to others and easier for your team and the community at large to maintain. My theory is that time spent initially building a more robust module will return you ten-fold the value over the life of that module in your environment.

(Testing as Documentation)
I shouldn't have to dig into your manifest's directory and read the code just to figure out how it works. Documentation is key to quality modules that people will use.

It may sound obvious that you should test your module, but you really should. To start, this means making sure your module does what you claimed it can do in your documentation. This is commonly and pretty simply solved with smoke tests. As an overview, we have a great docs article on writing, running, and reading smoke tests.

On a basic level, this means you test your module's functionality against the operating systems you claim to support and include the puppet code you used to conduct your tests (usually class declarations) in the tests folder of your module. This convention allows consumers of your module to easily rerun the smoke tests you ran but also serve as great ways for someone to quickly try out its functionality. If a contributor to your module adds new functionality, make sure they include a smoke test for you to use.

Extra Credit: Smoke tests are great, but some members of the Puppet community are building automated tests for their modules. The big two I'm aware of are rspec-puppet and cucumber-puppet. These are advanced techniques that come with a steep learning curve but if you're curious, there's a recent blog post on test driven development. Once achieved, these tests make it easy to protect against regressions when merging new code. If you're investing heavily into Puppet, it may be worth your time to learn.

Consistent, clean and usable code is important. So that other module users can use your module - reliable, predictable, readable

Style Guide
 Style Guide. It's a collection of stylistic preferences and code structure best practices that was originally written to help our organization develop code that we could all easily read and develop in a uniform manner. It's even more appropriate for the large, distributed audience consuming and contributing modules to the Puppet Forge.

So read and adhere to the Style Guide. Do it for your teammates, do it for the Forge. Puppet-lint .... does a style guide check. puppet-lint will scan your manifest code and alert you to certain violations against the Style Guide.


    @@@Puppet 
    gem install puppet-lint
    [root@centos6 modules]# cat helloworld/manifests/init.pp 
    class helloworld {
      notify { 'example':
    message => "Hello World!",
      }
    }
    [root@centos6 modules]# puppet-lint helloworld/manifests/init.pp 
    WARNING: double quoted string containing no variables on line 3

Puppet-lint doesn’t replace the Style Guide, so I encourage you to read it and keep it handy. You will find that it covers more than just the code styling that puppet-lint checks for. These are great tools to keep your code consistent, clean and consumable.

### slides

### slide

Why test?

You may wonder why you should bother with testing your Puppet code. After all, you probably have a great many demands on your precious time, right? And if your modules are working, and doing what they are intended to do, why waste valuable time with creating and running tests?

Well, actually, there are a number of good reasons.

Essentially, testing is a basic element of writing a great Puppet module.   

Primarily, testing is key to releasing high quality software. (and automating your tests ensures that testing is repeatable, reliable, and fast.)

Perhaps the best reason for testing is that when you make tests and testing  a standard element of your workflow, you'll find that you actually save yourself time. You'll find that you identify And likely you'll avoid some stress and frustration in the process. 


Publish
And finally, you may want to publish your module to the Puppet Forge to share out with the Puppet community. You will want to be sure that  .... and the way to accomplish this is through test.

### slide

Kinds of tests 



## Exercises

## Quiz

## References