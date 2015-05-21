# Puppet Smoke Testing

After basic code validation, the next level of testing is smoke testing.
The goal of smoke testing is to verify that your module runs and does what you want it to do.  

At the end of this course you will be able to:

* Set up dies 
* Write smoke tests
* Run smoke tests 

# Slide Content

## This is the content for the instructional video.


### slide Title - Puppet Module Smoke Testing

Doing some basic “Has it exploded?” testing on your Puppet modules is very simple, has obvious benefits during development, and can serve as a condensed form of documentation.

### slide Testing Flow

In relation to your Puppet modules, and in the context of software development, smoke testing is the first testing you perform, before more rigorous tests, simply to verify that your module runs. 

### Module Smoke testing

The baseline for module testing used by Puppet Labs is that each manifest should have a corresponding test manifest that declares that class or defined type. So - when you perform smoke testing on your puppet modules, you are testing your class declarations.

A well-formed Puppet module implements each of its classes or defined types in a separate file in its manifests directory.  In this example module directory tree structure,  s s h is the name of the module. There are two Puppet manifests, init and server. The init dot p p manifest defines the s s h class. The server manifest defines the s s h scope scope server class.

A test for a class is just a manifest that declares the class. Often, this is as simple as shown in our example, one line - include s s h.  In the tests directory there is a test for each manifest in the manifests directory. The init dot pp test declares the s s h class. The server dot p p test declares the s s h scope scope server class.  As you can see, if you create a test for each class, you will have a tests directory that is a mirror image of the manifests directory. 







(from writing your first module)

# Declaration Testing
## Preparing to test our declarations:

* Save example usage (class declarations) with the module.
    * ad hoc testing during development
    * example usage when sharing with others

.break text

    @@@ Shell
    [root@training ~]# tree /etc/puppetlabs/puppet/environments/production/modules/ssh
    ├── manifests
    │   ├── init.pp             ## class ssh { ... }
    │   └── server.pp           ## class ssh::server { ... }
    └── tests
        ├── init.pp             ## include ssh
        └── server.pp           ## include ssh::server

Each smoke test should declare the class it is testing.

    @@@ Puppet
    # /etc/puppetlabs/puppet/environments/production/modules/ssh/tests/init.pp

    include ssh

~~~SECTION:notes~~~
Puppet doesn't know anything about the `tests` directory. It is simply to
provide testing and example usage and is named for human convention. Typically,
there's just a single file for each class we write in the manifests directory
that just declare


Puppet Testing part i

The easiest and most basic way is known as Smoke Testing. I’m sure lots of people have used this method without even knowing it was an official way of testing.

Smoke Testing involves writing a basic manifest, then applying that manifest with the --noop option. That’s it.

As an example, let’s say you were writing a manifest to configure Apache on a server. It might look something like this:

include apache

apache::vhost { 'example.com':
  docroot     => '/var/www/example.com',
  serveralias => ['www.example.com']
}
Now instead of applying this manifest as-is, try it with --noop:

$ puppet apply --verbose --noop example.pp
...
Error: Invalid parameter serveralias at /root/example.pp:6 on node example.com
Notice the caught error.

serveralias is not a correct parameter, serveraliases is.

Smoke Testing is a very low-cost form of testing and I highly recommend utilizing it.


##Exercises

- Use the Puppet module tool to create a module with the following metadata:
    - puppet module generate <your_name>-ssh
    - accept the default version
    - accept default for name
    - accept default for license
    - describe the module: 