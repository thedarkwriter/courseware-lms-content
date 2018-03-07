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
keeps Puppet code organized in a way the Puppet master understands. 
To demonstrate these concepts, I'll create a new Puppet module to
manage two packages on the system: `cowsay` and  `fortune`.
These basics will provide a solid foundation  for more complex
code management methods for future Puppet code.

I'll start by using the quest command to set up the environmnent for this lesson:

    quest begin manifests_and_classes

### Manifests

At its simplest, a Puppet *manifest* is Puppet code saved to a file with the
`.pp` extension. This code is written in the Puppet *domain specific
language* (or DSL). I showed some examples of the Puppet language in the previous lessons when I discussed resources.
This language includes resource declarations, along with a set
of other language features, that let you control which resources are applied on
a system and what values are set for those resources' parameters.

<div class = "lvm-task-number"><p>Task 1:</p></div>

To demonstrate how a manifest works, I'll first ssh to the agent node created for this quest.

    ssh learning@cowsay.puppet.vm

Here, I'll create a throw-away manifest in the `/tmp/` directory. 

    vim /tmp/hello.pp

I'll use the same notify resource declaration I added to the `site.pp` in the
previous lesson:

```puppet
notify { 'Hello Puppet!': }
```

Rather than classifying this node on the master and triggering a Puppet agent
run, I'll apply this manifest directly with the `puppet apply` tool. I can use the
`puppet apply` tool to test Puppet code in a manifest just like I can use the 
`puppet resource` tool to explore and modify resources directly. When I run this
command, Puppet will generate and locally, without any communication to the Puppet
master.

    sudo puppet apply /tmp/hello.pp 

So I have this Puppet code saved to a file and I can apply it directly with the
`puppet apply` tool, but how do I incorporate manifests into Puppet's
master/agent architecture? The first step is to organize my Puppet code into
a *class* within the manifest, and place my manifest into a directory structure
called a *module*.

Before continuing, I'll disconnect from this agent node.

    exit

### Classes and modules

A *class* is named block of Puppet code. *Defining* a class
combines a group of resources into single reusable and configurable unit. Once
*defined*, a class can then be *declared*, which tells Puppet to actually apply the
resources it contains.

A class brings together the set of related resources involved in managing a given
component that you need configured on a node. For example, you could write a class to manage a MS SQL Server,
and this class would likely include resources to manage the package, configuration files, and service,
all of which are needed to install, configure, and run a MS SQL Server instance. Because
each of these components relies on the others, it's much easier to manage them all
from a single class.

A *module* gives you a way to bundle one or more related classes into a directory structure
you can add to your Puppet environment, track in a control repository, or even share with the
community on the Puppet Forge. A module contains Puppet manifests as well as any other data
these manifests might rely on, such as files, templates, custom resource types, or even plugins
that add new functions to the Puppet language.

The set structure of a module directory lets Puppet know where to look when you want
to use the Puppet code or other data bundled in a module. In the case of classes, this
process is called "autoloading." When you declare a class on a node, Puppet checks a
list of directories set by its *modulepath* parameter to find all the modules it has
available. It then uses the class name to find the exact module from which to load the
class definition.

All this will be much easier to understand with an example.
Let's dive in and get started writing a simple module.

## Write a cowsay module

I'll write a module to manage a small program called
cowsay. Cowsay prints a message inside a speech bubble coming from the
mouth of an ASCII cow printed to your terminal. In its first iteration,
the module will use a `package` resource to install the cowsay package.

Before I create a new manifest, I need to know where to keep it. For Puppet
to find my code, I need to create a new module in Puppet's *modulepath*.

I can see my configured modulepath by running the following command:

    puppet config print modulepath

The output is a list of directories separated by the colon (`:`) character.

```
/etc/puppetlabs/code/environments/production/modules:/etc/puppetlabs/code/modules:/opt/puppetlabs/puppet/modules
```

For now, I'll work in the first directory listed in the modulepath. This
directory includes modules specific to the production environment. If you're curious
about the other directories, etc/puppetlabs/code/modules contains modules used
across all envrionments, while opt/puppetlabs/puppet/modules contains modules that PE
uses to configure itself.

Because I'm focusing on the structure of my module and class, I'll
write code directly to the modulepath on the master. In a real production
environment I would likely want to keep my Puppet code in a
version control repository such as Git and use Puppet's code manager tool to
deploy it to my master. However, because this process would require some external
setup and a somewhat more complex workflow to introduce and approve code
changes, it will be more efficient to edit code directly for now, and
address code management in a separate lesson.

<div class = "lvm-task-number"><p>Task 2:</p></div>

First, I'll navigate to the `modules` directory.

    cd /etc/puppetlabs/code/environments/production/modules

Next, I'll create a directory structure for a new module called `cowsay`. Notice that the `-p`
flag allows me to create the `cowsay` parent directory and `manifests`
subdirectory at once.

    mkdir -p cowsay/manifests

With this directory strucure in place, it's time to create the manifest where
I'll write the definition for my `cowsay` class.

<div class = "lvm-task-number"><p>Task 3:</p></div>

I'll use vim to create an `init.pp` manifest in my module's `manifests` directory.

    vim cowsay/manifests/init.pp

You might be wondering why I'm calling this manifest `init.pp` instead of
calling it `cowsay.pp` to correspond with the name of the class it contains.
The class whose name corresponds with the name of the module itself always
goes in a manifest with the special name `init.pp`.

Now that I have this init.pp file open, I'll go ahead and enter the class
definition

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
version of the package written in Ruby and published to the RubyGems repository.

It's always good practice to validate code before trying to apply it. I can use
the `puppet parser` tool to check the syntax of my new manifest.

    puppet parser validate cowsay/manifests/init.pp
	
The parser will return nothing if there are no errors. If it does detect a
syntax error, I can open the file again and fix the problem before continuing. 
It's important to note that this validataion can only catch simple syntax errors and won't
tell me about other possible problems that might make the manifest fail to compile
or not work as expected.

Now that the `cowsay` class is defined in my module's `init.pp` manifest,
the Puppet master knows exactly where to find the appropriate Puppet code when
I apply the `cowsay` class to a node.

<div class = "lvm-task-number"><p>Task 4:</p></div>

In the setup for this lesson, I prepared a `cowsay.puppet.vm`
node. I'll apply the `cowsay` class to this node. First, I'll open my `site.pp`
manifest.

    vim /etc/puppetlabs/code/environments/production/manifests/site.pp

At the end of the `site.pp` manifest, I'll insert a node definition
for the cowsay.puppet.vm node and use an an `include` statement to apply
the cowsay class to this node:

```puppet
node 'cowsay.puppet.vm' {
  include cowsay
}
```

This `include cowsay` line tells the Puppet master to parse the contents of the
`cowsay` class when it compiles a catalog for the `cowsay.puppet.vm` node.

<div class = "lvm-task-number"><p>Task 5:</p></div>

Now that I've added the `cowsay` class to my classification for the
`cowsay.puppet.vm` node, I can connect to that node and trigger a Puppet agent
run to see the changes applied.

    ssh learning@cowsay.puppet.vm

Before applying any changes to the system, it's often a good idea to use the
`--noop` flag to do a practice run of the Puppet agent. This will compile the
catalog and notify me of the changes that Puppet would have made without
actually applying any of those changes to my system. It's a good way to catch
issues the `puppet parser validate` command can't detect, and it gives me a
chance to validate that Puppet will be making the changes I expect.

    sudo puppet agent -t --noop

Looking at the output, I can see the differences between the node's current
state and the desired state defined in the catalog as well as what the Puppet
agent would have done to correct these differences:

    Notice: Compiled catalog for cowsay.puppet.vm in environment production in
    0.62 seconds
    Notice: /Stage[main]/Cowsay/Package[cowsay]/ensure: current_value
    absent, should be present (noop)
    Notice: Class[Cowsay]: Would have triggered 'refresh' from 1
    events
    Notice: Stage[main]: Would have triggered 'refresh' from 1 events
    Notice: Finished catalog run in 1.08 seconds

This test run looks good, so I'll run the Puppet agent again without the
`--noop` flag.

    sudo puppet agent -t

Now that the Puppet run is complete I can finally try out my newly installed cowsay command:

    cowsay Puppet is awesome!

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
single function. Cowsay alone is great, but not everyone has the time to
think of clever messages for their cow to say. For
this reason, cowsay is often used in conjunction with the `fortune` command,
which I can use to provide my cow and me with a database of sayings and wisdom.

<div class = "lvm-task-number"><p>Task 6:</p></div>

I'll disconnect from the `cowsay.puppet.vm` node and return to my master.

    exit

Now I can create a new manifest for my `fortune` class definition.

    vim cowsay/manifests/fortune.pp

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
colons that connect `cowsay` and `fortune` are a scope resolution operator and
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
into the main `cowsay` class.

    vim cowsay/manifests/init.pp

```puppet
class cowsay {
  package { 'cowsay':
    ensure   => present,
    provider => 'gem',
  }
  include cowsay::fortune
}
```

Again, I'll use the `puppet parser validate` command to check my syntax.

    puppet parser validate cowsay/manifests/init.pp

<div class = "lvm-task-number"><p>Task 8:</p></div>

Finally, I'll return to my `cowsay.puppet.vm` node so I can test out these changes.

    ssh learning@cowsay.puppet.vm

Once again, I'll trigger a Puppet agent run with the `--noop` flag to check what changes Puppet
will make.

    sudo puppet agent -t --noop

Because the cowsay package is already installed, Puppet
won't make any changes to this package. And, now that I've included the
`cowsay::fortune` package, Puppet knows that it needs to install the
`fortune-mod` package to bring my node into the desired state.

I'll trigger another Puppet run without the `--noop` flag to make these changes.

    sudo puppet agent -t

Now that I have both packages installed, I can use them together and 
pipe the output of the `fortune` command to `cowsay`.

    fortune | cowsay

I've seen the results of my Puppet run, so I'll disconnect to return to
the Puppet master.

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
