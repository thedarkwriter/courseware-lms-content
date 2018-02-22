{% include '/version.md' %}

# Manifests and classes

## Getting started

In previous lessons, I've described the basics of Puppet's *resource abstraction
layer*, the relationship between the Puppet agent and master, and the
communication between the agent and master involved in a Puppet agent run.
Other than modifying a few basic resources, however, I haven't yet written
much Puppet code.

The patterns and workflows used to organize, maintain, and deploy Puppet code
are just as important as the code itself. Starting with good design will keep everything working smoothly when managing a more complex Puppet infrastructure.

In this lesson, I'll cover how Puppet code is organized into *manifests*,
*classes*, and *modules* and how to apply classes to nodes with the
`site.pp` manifest. I'll also show how the module structure 
keeps Puppet code organized in a way the Puppet master understands, 
and I'll create a new Puppet module to manage the `cowsay` and 
`fortune` packages. These basics will provide a solid foundation 
for more complex code management methods for future Puppet
code.


I'll start by entering the following command:

    quest begin manifests_and_classes

### Manifests

At its simplest, a Puppet *manifest* is Puppet code saved to a file with the
`.pp` extension. This code is written in the Puppet *domain specific
language* (DSL). I showed some examples of this DSL in the previous lessons when I discussed resources.
The Puppet DSL includes resource declarations, along with a set
of other language features, that let us control which resources are applied on
a system and what values are set for those resources' parameters.

<div class = "lvm-task-number"><p>Task 1:</p></div>

I have sshed into my node and will now create a throw-away manifest in my `/tmp/` directory to show how this works. 

    vim /tmp/hello.pp

I use the same notify resource declaration I included in `site.pp` in the
previous lesson:

```puppet
notify { 'Hello Puppet!': }
```

Rather than classifying this node on the master and triggering a Puppet agent
run, I apply this manifest directly with the `puppet apply` tool. I can use the
`puppet apply` tool to test Puppet code in a manifest just like I can use the 
`puppet resource` tool to explore and modify resources directly.

    sudo puppet apply /tmp/hello.pp 

So now I have saved Puppet code to a file, but how do I bridge the gap
between this saved Puppet code and the `site.pp` manifest where I defined
node classification? The first step is to organize my Puppet code into
*classes* and *modules*.

### Classes and modules

A *class* is named block of Puppet code. *Defining* a class
combines a group of resources into single reusable and configurable unit. Once
*defined*, a class can then be *declared* to tell Puppet to apply the
resources it contains.

A class should bring together a set of resources that manage one logical
component of a system. For example, a class written to manage a MS SQL Server
might include resources to manage the package, configuration files, and service
for the MS SQL Server instance. Because each of these components relies on the
others, it makes sense to manage them together. We're not likely to want a server with
MS SQL configuration files without the MS SQL application package itself.

A *module* is a directory structure that allows Puppet to keep track of where to
find the manifests that contain classes. A module also contains other data
a class might rely on, such as the templates for configuration files. When I
apply a class to a node, the Puppet master checks in a list of directories
called a *modulepath* for a module directory matching the class name. The master then
looks in that module's `manifests` subdirectory to find the manifest containing
the class definition. It reads the Puppet code contained in that class
definition and uses it to compile a catalog defining a desired state for the
node.

All this will be much easier to understand with an example.
Let's dive in and write a simple module.

## Write a cowsay module

By way of example, I'll write a module to manage a small program called
cowsay. Cowsay prints a message inside a speech bubble coming from the
mouth of an ASCII cow.

Before I create a new manifest, I need to know where to keep it. For Puppet
to find my code, I need to place it in a module directory in Puppet's
*modulepath*.

I've disconnected from `cowsay.puppet.vm` and returned to my master.
I can see my configured modulepath by running the following command:

    puppet config print modulepath

The output is a list of directories separated by the colon (`:`) character.

```
/etc/puppetlabs/code/environments/production/modules:/etc/puppetlabs/code/modules:/opt/puppetlabs/puppet/modules
```

For now, I'll work in the first directory listed in the modulepath. This
directory includes modules specific to the production environment. (The second directory
contains modules used across all environments, and the third is modules that PE
uses to configure itself).

Because I'm focusing on the structure of my module and class, I'll
write code directly to the modulepath on the master. In a real production
environment, however, I would likely want to keep my Puppet code in a
version control repository such as Git and use Puppet's code manager tool to
deploy it to my master. 

<div class = "lvm-task-number"><p>Task 2:</p></div>

I navigate to the `modules` directory.

    cd /etc/puppetlabs/code/environments/production/modules

Then, I create a directory structure for a new module called `cowsay`. The `-p`
flag allows me to create the `cowsay` parent directory and `manifests`
subdirectory at once.

    mkdir -p cowsay/manifests

With this directory strucure in place, it's time to create the manifest where
I'll write the `cowsay` class.

<div class = "lvm-task-number"><p>Task 3:</p></div>

I use vim to create an `init.pp` manifest in my module's `manifests` directory.

    vim cowsay/manifests/init.pp

If this manifest is going to contain the `cowsay` class, why am I calling it `init.pp` instead of `cowsay.pp`?
Most modules contain a main class like this whose name corresponds with the name of the module itself.
This main class is always kept in a manifest with the special name `init.pp`.

Now I will enter the following class definition, save, and exit:

```puppet
class cowsay {
  package { 'cowsay':
    ensure   => present,
    provider => 'gem',
  }
}
````
``:wq``

Notice that I've specified `gem` as the provider for this package. Apparently
`cowsay` isn't important enough to live in any of the default yum package
repositories, so I'm telling Puppet to use the `gem` provider to install a
version of the package written in Ruby and published on RubyGems.

It's always good practice to validate code before trying to apply it. I can use
the `puppet parser` tool to check the syntax of my new manifest.

    puppet parser validate cowsay/manifests/init.pp
	
The parser will return nothing if there are no errors. If it does detect a
syntax error, I can open the file again and fix the problem before continuing. 
It's important to note that this validataion can only catch simple syntax errors and won't
notify me about other possible errors in my manifests.

Now that the `cowsay` class is defined in my module's `init.pp` manifest,
the Puppet master knows exactly where to find the appropriate Puppet code when
I apply the `cowsay` class to a node.

<div class = "lvm-task-number"><p>Task 4:</p></div>

In the setup for this lesson, I prepared a `cowsay.puppet.vm`
node. Let's apply the `cowsay` class to this node. First, I open my `site.pp`
manifest.

    vim /etc/puppetlabs/code/environments/production/manifests/site.pp

At the end of the `site.pp` manifest, I insert the following code:

```puppet
node 'cowsay.puppet.vm' {
  include cowsay
}
```

Then, I save and exit.

This `include cowsay` line tells the Puppet master to parse the contents of the
`cowsay` class when it compiles a catalog for the `cowsay.puppet.vm` node.

<div class = "lvm-task-number"><p>Task 5:</p></div>

Now that I've added the `cowsay` class to my classification for the
`cowsay.puppet.vm` node, I want to connect to that node and trigger a Puppet agent
run to see the changes applied.

    ssh learning@cowsay.puppet.vm

Before applying any changes to my system, it's always a good idea to use the
`--noop` flag to do a practice run of the Puppet agent. This will compile the
catalog and notify me of the changes that Puppet would have made without
actually applying any of those changes to my system. It's a good way to catch
issues the `puppet parser validate` command can't detect, and it gives me a
chance to validate that Puppet will be making the changes I expect.

    sudo puppet agent -t --noop

I see the following output:

    Notice: Compiled catalog for cowsay.puppet.vm in environment production in
    0.62 seconds
    Notice: /Stage[main]/Cowsay/Package[cowsay]/ensure: current_value
    absent, should be present (noop)
    Notice: Class[Cowsay]: Would have triggered 'refresh' from 1
    events
    Notice: Stage[main]: Would have triggered 'refresh' from 1 events
    Notice: Finished catalog run in 1.08 seconds

My dry run looks good, so I am going to run the Puppet agent again without the
`--noop` flag.

    sudo puppet agent -t

I can finally try out my newly installed cowsay command:

    cowsay Puppet is awesome!

Our bovine friend clearly knows what's up.

     ____________________
    < Puppet is awesome! >
     --------------------
            \   ^__^
             \  (oo)\_______
                (__)\       )\/\
                    ||----w |
                    ||     ||

### Composed classes and class scope

A module often includes multiple components that work together to serve a
single function. Cowsay alone is great, but many users don't have the time to
write out a custom high-quality message on each execution of the command. For
this reason, cowsay is often used in conjunction with the `fortune` command,
which provides me and my cow with a database of sayings and wisdom to draw
on.

<div class = "lvm-task-number"><p>Task 6:</p></div>

I'll disconnect from the `cowsay.puppet.vm` node and return to my master.
Now I can create a new manifest for my `fortune` class definition.

    vim cowsay/manifests/fortune.pp

My class definitions go here:

```puppet
class cowsay::fortune {
  package { 'fortune-mod':
    ensure => present,
  }
}
```

Note that unlike the main `init.pp` manifest, the filename of the manifest
shows the name of the class it defines. In fact, because this class is
contained in the `cowsay` module, its full name is `cowsay::fortune`. The two
colons that connect `cowsay` and `fortune` are pronounced "scope scope" and
indicate that this `fortune` class is contained in the cowsay module scope.
Notice how the fully scoped name of the class tells Puppet exactly where to
find it in my module path: the `fortune.pp` manifest in the `cowsay` module's
`manifests` directory. This naming pattern also helps avoid conflicts among
similarly named classes provided by different modules.

<div class = "lvm-task-number"><p>Task 7:</p></div>

Once again, I'll validate my new manifest's syntax with the `puppet parser validate`
command.

    puppet parser validate cowsay/manifests/fortune.pp

I could use another include statement in the `site.pp` manifest to classify
`cowsay.puppet.vm` with this `cowsay::fortune` class. In general, however, it's
best to keep classification as simple as possible.

In this case, I'll use a class declaration to pull the `cowsay::fortune` class
into our main `cowsay` class.

    vim cowsay/manifests/init.pp

I'll also add an include statement for my `cowsay::fortune` class to the cowsay class.

```puppet
class cowsay {
  package { 'cowsay':
    ensure   => present,
    provider => 'gem',
  }
  include cowsay::fortune
}
```

I use the `puppet parser validate` command to check my syntax and make sure it looks good.

    puppet parser validate cowsay/manifests/init.pp

<div class = "lvm-task-number"><p>Task 8:</p></div>

Now I will return to my `cowsay.puppet.vm` node so I can test out these changes.

    ssh learning@cowsay.puppet.vm

Once again, I trigger a Puppet agent run with the `--noop` flag to check what changes Puppet
will make.

    sudo puppet agent -t --noop

Because the cowsay package is already installed, Puppet
won't make any changes to this package. And, now that I've included the
`cowsay::fortune` package, Puppet knows that it needs to install the
`fortune-mod` package to bring my node into the desired state.

I trigger another Puppet run without the `--noop` flag to make these changes.

    sudo puppet agent -t

Now that I have both packages installed, I can use them together and 
pipe the output of the `fortune` command to `cowsay`.

    fortune | cowsay

I've seen the results of my Puppet run, so I'll disconnect to return to
my Puppet master.

    exit
	
## Review

I began this lesson with a discussion of the importance of keeping Puppet
code well organized. This structure of *classes*, *manifests*, and *modules*
keeps code organized in logical, reusable units. Keeping modules within
Puppet's *modulepath* allows the Puppet master to find the classes contained
within them.

I showed how to create a new module to manage the `cowsay`
package, and then extended this module by creating a new class to manage the
`fortune-mod` package.

I'll continue to use this organizational scheme to structure the Puppet code I write throughout the following lessons.
