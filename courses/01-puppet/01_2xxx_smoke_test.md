# Puppet Smoke Tests

Wkipedia

Smoke testing (software): trying the major functions of software before carrying out formal testing

In computer programming and software testing, smoke testing (also confidence testing, sanity testing[1]) is preliminary testing to reveal simple failures severe enough to reject a prospective software release. A subset of test cases that cover the most important functionality of a component or system is selected and run, to ascertain if crucial functions of a program correctly work.[2][1]:37 When used to determine if a computer program should be subjected to further, more fine-grained testing, a smoke test may be called an intake test.[1]:25

For example, a smoke test may ask basic questions like "Does the program run?", "Does it open a window?", or "Does clicking the main button do anything?" The process aims to determine whether the application is so badly broken as to make further immediate testing unnecessary. As the book "Lessons Learned in Software Testing" [3] puts it, "smoke tests broadly cover product features in a limited time ... if key features don't work or if key bugs haven't yet been fixed, your team won't waste further time installing or testing".[4]


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