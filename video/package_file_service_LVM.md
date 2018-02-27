{% include '/version.md' %}

# Package file service

In this lesson, I will use the `package`, `file` and `service` resources together to
manage an application and I'll also cover resource ordering metaparameters to define 
dependencies among resources. 


## The package, file, service pattern 

In the previous lesson, I created a simple module to manage the `cowsay` and
`fortune-mod` packages. However, I often need Puppet to manage several
related resource types to get my managed system to its desired state. The
`package`, `file`, and `service` resource types are used in concert often
enough that we talk about them together as the "package, file, service"
pattern. A package resource manages the software package itself, a file
resource allows me to customize a related configuration file, and a service
resource starts the service provided by the software I've just installed and
configured.

To give an example to work with, I've created a simple Ruby application 
called Pasture. Pasture provides cowsay's functionality over RESTful API 
so that my cows can be accessible over HTTP — we
might call this cowsay as a service (CaaS). Look for a link below this video to
Pasture's source code. This Pasture application may be whimsical, 
but its simplicity allows me to focus on Puppet itself
without taking detours to cover the features and caveats of a more complex
application.

Just like the cowsay command line tool, I'll use a `package` resource with the
`gem` provider to install Pasture.

Next, because Pasture reads from a configuration file, I'm going to use a
`file` resource to manage its settings.

Finally, I want Pasture to run as a persistent background process, rather than
running once like the cowsay command line tool. It needs to listen for incoming
requests and serve out cows as needed. To set this up, I'll first have to
create a `file` resource to define the service, then use a `service` resource
to ensure that it's running.

## Getting started

I enter the following command to get started:

    quest begin package_file_service


## Package

<div class = "lvm-task-number"><p>Task 1:</p></div>

Before getting started, I want to be sure I'm in my Puppet master's `modules`
directory.

    cd /etc/puppetlabs/code/environments/production/modules

I'll create a new directory structure for my `pasture` module. This time, the
module will include two subdirectories: `manifests` and `files`.

    mkdir -p pasture/{manifests,files}

<div class = "lvm-task-number"><p>Task 2:</p></div>

I open a new `init.pp` manifest to begin the definition of the main `pasture`
class. 

    vim pasture/manifests/init.pp

So far, this should look just like the `cowsay` class, except that the package
resource will manage the `pasture` package instead of `cowsay`.

```puppet
class pasture {
  package { 'pasture':
    ensure   => present,
    provider => gem,
  }
}
```

I'll use the `puppet parser` tool to validate my syntax and make any changes
necessary.

    puppet parser validate pasture/manifests/init.pp

<div class = "lvm-task-number"><p>Task 3:</p></div>

Before continuing, I'm going to apply this class to see where this file resource
has gotten me.

I open my `site.pp` manifest.

    vim /etc/puppetlabs/code/environments/production/manifests/site.pp

And create a new node definition for the `pasture.puppet.vm` node I've set up for
this quest. I include the `pasture` class I just wrote.

```puppet
node 'pasture.puppet.vm' {
  include pasture
}
```
<div class = "lvm-task-number"><p>Task 4:</p></div>

Now I connect to the `pasture.puppet.vm` node.

    ssh learning@pasture.puppet.vm 

And trigger a Puppet agent run.

    sudo puppet agent -t

<div class = "lvm-task-number"><p>Task 5:</p></div>

With the `pasture` gem installed, I can use the `pasture start` command. I haven't set up a service to manage this
process yet, but I can add an ampersand (`&`) after the command to start
it in the background.

    pasture start &

As the process starts, it will write some output to the terminal, but it will not
prevent me from entering new commands. To get a clean prompt for my
next command, I can just hit the `enter` key.

<div class = "lvm-task-number"><p>Task 6:</p></div>

I use the `curl` command to test the Pasture API. The request takes two
parameters, `string`, which defines the message to be returned, and
`character`, which sets the character I want to speak the message. By
default, the process listens on port 4567. Try the following command:

    curl 'localhost:4567/api/v1/cowsay?message=Hello!'

By default, my message will be spoken by the cow character. I want to pass
in another parameter to change this.

    curl 'localhost:4567/api/v1/cowsay?message=Hello!&character=elephant'

<div class = "lvm-task-number"><p>Task 7:</p></div>

I can experiment with other parameters, if I want. When I'm done, I use the `fg`
command to foreground the `pasture` process:

    fg

And use the `CTRL-C` key combination to end the process:  

`CTRL-C`  

If `fg` doesn't foreground the process, I can use the `ps` command to find the
`pasture` process's PID and use the `kill` command with that PID (e.g. `kill
5983`) to stop the process.

Once I've stopped the process, I disconnect from the agent node.

    exit

## File

Packages installed with Puppet often have configuration files that let you
customize their behavior. I've written the Pasture gem to use a simple
configuration file. Once you understand the basic concept, it will be easy to
extend to more complex configurations.

I already created a `files` directory inside the `pasture` module directory.
Just like placing manifests inside a module's `manifests` directory allows Puppet
to find the classes they define, placing files in the module's `files` directory
makes them available to Puppet.

<div class = "lvm-task-number"><p>Task 8:</p></div>

I'll create a `pasture_config.yaml` file in my module's `files` directory.

    vim pasture/files/pasture_config.yaml

I include a line here to set the default character to `elephant`.

```yaml
---
:default_character: elephant
```

With this source file saved to my module's `files` directory, I can use
it to define the content of a `file` resource.

The `file` resource takes a `source` parameter, which allows me to specify a
source file that will define the content of the managed file. As its value,
this parameter takes a URI. While it's possible to point to other locations,
this is typically used to specify a file in the module's `files` directory.
Puppet uses a shortened URI format that begins with the `puppet:` prefix to
refer to these module files kept on the Puppet master. This format follows the
pattern `puppet:///modules/<MODULE NAME>/<FILE PATH>`. Notice the triple
forward slash just after `puppet:`. This stands in for the implied path to the
modules on my Puppet master.

Don't worry if this URI syntax seems complex. It's pretty rare that you'll need
to use it for anything other than referring to files within your modules, so
the pattern above is likely all you'll need to learn. You can always refer back
to the docs that arelinked below this video for a reminder.

<div class = "lvm-task-number"><p>Task 9:</p></div>

I now return to my `init.pp` manifest.

    vim pasture/manifests/init.pp

And add a file resource declaration.

```puppet
class pasture {

  package { 'pasture':
    ensure   => present,
    provider => 'gem',
  }

  file { '/etc/pasture_config.yaml':
    source => 'puppet:///modules/pasture/pasture_config.yaml',
  }
}
```

I'll check my syntax with the `puppet parser` tool.

    puppet parser validate pasture/manifests/init.pp

## Service

While the cowsay command I installed in the previous quest runs once and
exits, Pasture is intended to be run as a service. A Pasture process will run
in the background and listen for any incoming requests on its designated port.
Because my agent node is running CentOS 7, I'll use the systemd
service manager to handle my Pasture process.
Although some packages set up their own service unit files, Pasture does not.
It's easy enough to use a `file` resource to create my own. This service unit
file will tell systemd how and when to start my Pasture application.

<div class = "lvm-task-number"><p>Task 10:</p></div>

First, I create a file called `pasture.service`.

    vim pasture/files/pasture.service

And include the following contents:

```
[Unit]
Description=Run the pasture service

[Service]
Environment=RACK_ENV=production
ExecStart=/usr/local/bin/pasture start

[Install]
WantedBy=multi-user.target
```

If you're not familiar with the format of a systemd unit file, don't worry
about the details here. The beauty of Puppet is that the basic principles you
learn with this example will be easily portable to whatever system you work
with.

<div class = "lvm-task-number"><p>Task 11:</p></div>

Now I open `init.pp` manifest again.

    vim pasture/manifests/init.pp

First, I add a file resource to manage my service unit file.

```puppet
class pasture {

  package { 'pasture':
    ensure   => present,
    provider => 'gem',
  }

  file { '/etc/pasture_config.yaml':
    source => 'puppet:///modules/pasture/pasture_config.yaml',
  }

  file { '/etc/systemd/system/pasture.service':
    source => 'puppet:///modules/pasture/pasture.service',
  }

}
```

Next, I add the `service` resource itself. This resource will have the title
`pasture` and a single parameter to set the state of the service to `running`.

```puppet
class pasture {

  package { 'pasture':
    ensure   => present,
    provider => 'gem',
  }

  file { '/etc/pasture_config.yaml':
    source => 'puppet:///modules/pasture/pasture_config.yaml',
  }

  file { '/etc/systemd/system/pasture.service':
    source => 'puppet:///modules/pasture/pasture.service',
  }

  service { 'pasture':
    ensure => running,
  }

}
```

## Resource ordering

There's one more step before this class is complete. I need a way to ensure
that the resources defined in this class are managed in the correct order. The
"package, file, service" pattern describes the common dependency relationships
among these resources: I want to install a package, write a configuration
file, and start a service, in that order. Furthermore, if I make changes to
the configuration file later, I want Puppet to restart my service so it can
pick up those changes.

Though Puppet code will default to managing resources in the order they're
written in a manifest, we strongly recommend that you make dependencies among
resources explicit through relationship metaparameters.
A metaparameter is a parameter that affects *how* Puppet handles a resource
rather than directly defining its desired state. Relationship metaparameters
tell Puppet about ordering relationships among resources.

For my class, I'll use two relationship metaparameters: `before` and
`notify`. `before` tells Puppet that the current resource must come before the
target resource. The `notify` metaparameter is like `before`, but if the target
resource is a service, it has the additional effect of restarting the service
whenever Puppet modifies the resource with the metaparameter set. This is
useful when I need Puppet to restart a service to pick up changes in a
configuration file.

Relationship metaparameters take a resource
reference as a value. This resource reference points to another resource in 
my Puppet code. The syntax for a resource reference is the capitalized resource type,
followed by square brackets containing the resource title: `Type['title']`. 

<div class = "lvm-task-number"><p>Task 12:</p></div>

I'll now open my `init.pp` manifest.

    vim pasture/manifests/init.pp

I add relationship metaparameters to define the dependencies among my
`package`, `file`, and `service` resources. 

```puppet
class pasture {

  package { 'pasture':
    ensure   => present,
    provider => 'gem',
    before   => File['/etc/pasture_config.yaml'],
  }

  file { '/etc/pasture_config.yaml':
    source  => 'puppet:///modules/pasture/pasture_config.yaml',
    notify  => Service['pasture'],
  }

  file { '/etc/systemd/system/pasture.service':
    source  => 'puppet:///modules/pasture/pasture.service',
    notify  => Service['pasture'],
  }

  service { 'pasture':
    ensure => running,
  }

}
```

When I've finished, I'll check my syntax one more time with the `puppet parser`
tool.

    puppet parser validate pasture/manifests/init.pp

The `pasture.puppet.vm` node is still classified with this `pasture` class.
When I return to the node and do another puppet agent run, the master will
pick up these added file and service resources and include them in the catalog
it returns to the node.

<div class = "lvm-task-number"><p>Task 13:</p></div>

I'll go ahead ahead and connect to `pasture.puppet.vm`.

    ssh learning@pasture.puppet.vm

And trigger another Puppet agent run.

    sudo puppet agent -t

Now that the `pasture` service is configured and running, I can disconnect from the
agent node.

    exit

From the master, I use the `curl` command to retrieve an ASCII elephant from
port 4567 of the `pasture.puppet.vm` node.

    curl 'pasture.puppet.vm:4567/api/v1/cowsay?message=Hello!'

## Review

In this lesson, I showed some of the specifics of writing Puppet code.
I used the common "package, file, service" pattern to configure the Pasture
application and set up a service unit to run its process on my server.

I also showed how to make a file available to Puppet by placing it in my
module's `files` directory. With that file in place, I used it
in a `file` resource with the `source` parameter and a URI.

Finally, I went over resource ordering. I used the `before` and `notify`
metaparameters to define relationships among the resources in my class to
ensure that Puppet will manage the resources in the correct order and refresh
the service when its configuration file is modified.

In the next lesson, I'll explain how to make this class more flexible by adding
variables and replacing static files with templates.


