# Inheritance
Classes can be derived from other classes using the `inherits` keyword. This allows you to make special-case classes that extend the functionality of a more general “base” class.

**Note**: Puppet 3 does not support using parameterized classes for inheritable base classes. The base class **must** have no parameters.

At the end of this course you will be able to:

* define inheritance.
* identify appropriate use cases for inheritance.
* list best practices for inheritance.

## Video ##
[Link to Video](http://linktovideo)

## Exercises ##

Login shells are the programs that users interact with. They interpret commands typed at the command line. We would like to provide a new shell for our users, and we’ll customize the configuration file a bit for all of our users. We would also like to customize this default configuration file for a subset of our users to provide handy shortcuts and aliases that are useful for software developers.

Change your current working directory to your modulepath with

`cd /etc/puppetlabs/puppet/modules`

Examine the directory structure of the example zsh module.

<pre><code>[root@training modules]# tree zsh/
zsh/
├── files
│   ├── zshrc
│   └── zshrc.dev
├── manifests
│   └── init.pp
├── Modulefile
├── README
├── spec
│   └── spec_helper.rb
└── tests
    └── init.pp</code></pre>

We will start with this zsh module that manages the shell. Create a new class called `zsh::developer` that inherits from the `zsh` class and overrides the `File['/etc/zshrc']` resource to change the location that the file is sourced from to `puppet:///modules/zsh/zshrc.dev`

*   `cd /etc/puppetlabs/puppet/modules`
*   `vim zsh/manifests/developer.pp`

Also create a test manifest in order to verify your code.

`vim zsh/tests/developer.pp`

Finally, incorporate the ordering from the [Relationships](https://dev.puppetlabs.com/learn/relationships) lesson to ensure that the configuration file is written out after the package is installed. To do so, edit the main `zsh` class:

`vim zsh/manifests/init.pp`

and add a `before` attribute to the `Package['zsh']` resource

`before => File['/etc/zshrc'],`

Test and enforce your test manifest.

*   `puppet parser validate zsh/manifests/developer.pp`
*   `puppet apply zsh/tests/developer.pp`

## Quiz ##
1. The Puppet keyword used to extend the functionality of a class is called:
a. extend b. declare c. **inherits** d. include
2. True or False. When the derived (inherited) class is declared, its base class is automatically declared first. (True)
3. You have a base class called `ssh` that you need to extend. The new class will be called `paranoid`. Which of the following is the correct syntax for the first line of the `paranoid` class?
a. `class paranoid extends ssh {`
b. `class paranoid inherits ssh {`
c. `class ssh declares paranoid {`
d. `class ssh::paranoid inherits ssh {`
b or d
4. True or False. Inheritance should be used within a module to reduce repitition. (True)
5. True or False. It is considered a best practice to use inheritance across modules. (False)

## Resources ##
* [Inheritance - Docs](http://docs.puppetlabs.com/puppet/3/reference/lang_classes.html#inheritance)
* [Inheritance - Style](http://docs.puppetlabs.com/guides/style_guide.html#class-inheritance)
