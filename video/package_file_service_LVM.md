{% include '/version.md' %}

# Package file service

In this lesson, I'll demonstrate the common `package`, `file` and `service` pattern
used manage applications, and introduce the concept of resource ordering to define 
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
might call this a cowsay as a service application. If you're interested, 
look for a link below this video to
Pasture's source code. This Pasture application may seem a bit whimsical, 
but its simplicity lets me to focus on Puppet itself
without taking detours to cover the features and caveats of a more complex
application.

Just like I did in the last video for the cowsay command line tool, I'll use a `package` resource with the
`gem` provider to install Pasture.

Next, because Pasture reads from a configuration file, I'm going to use a
`file` resource to manage its settings.

Finally, I want Pasture to run as a persistent background process, rather than
running once like the cowsay command line tool. It needs to listen for incoming
requests and serve out cows as needed. To set this up, I'll first have to
create another `file` resource to define the service, then use a `service` resource
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

I'll open a new `init.pp` manifest to begin the definition of the main `pasture`
class. 

    vim pasture/manifests/init.pp

So far, this should look just like the `cowsay` class I created in the last lesson,
that the package resource will manage the `pasture` package instead of `cowsay`.

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

Before continuing, I'll try out class to see where this file resource
has gotten me.

I'll open my `site.pp` manifest.

    vim /etc/puppetlabs/code/environments/production/manifests/site.pp

And create a new node definition for the `pasture.puppet.vm` node I've set up for
this quest. Here, I'll include the `pasture` class I just wrote.

```puppet
node 'pasture.puppet.vm' {
  include pasture
}
```
<div class = "lvm-task-number"><p>Task 4:</p></div>

Now I'll connect to the `pasture.puppet.vm` node.

    ssh learning@pasture.puppet.vm 

And trigger a Puppet agent run.

    sudo puppet agent -t

<div class = "lvm-task-number"><p>Task 5:</p></div>

With the `pasture` gem installed, I can use the `pasture start` command. I haven't set up a service to manage this
process yet, so I'll run it manually from the command-line and append an
ampersand character (`&`) after the command so the process will run in
the background.

    pasture start &

As the process starts, it writes some output to the terminal, but it won't
prevent me from entering new commands. To get a clean prompt for my
next command, I'll just hit the `enter` key.

<div class = "lvm-task-number"><p>Task 6:</p></div>

I can use the `curl` command to test the API provided by the running Pasture
process. The request takes two
parameters, `string`, which defines the message to be returned, and
`character`, which sets the character I want to speak the message. By
default, the process listens on port 4567.

    curl 'localhost:4567/api/v1/cowsay?message=Hello!'

By default, my message is the cow character, but I can pass
in another parameter to change this.

    curl 'localhost:4567/api/v1/cowsay?message=Hello!&character=elephant'

<div class = "lvm-task-number"><p>Task 7:</p></div>

Now that I've taken some time to explore this API, I'll use the `fg`
command to foreground the `pasture` process and CTRL-C to stop it:

    fg

`CTRL-C`  

Once I've stopped the process, I'll disconnect from the agent node so
I can return to the Puppet master and continue work on my module.

    exit

## File

Packages installed with Puppet often have configuration files that let you
customize their behavior. I wrote the Pasture gem to use a simple
configuration file you can use to configure the default message and character,
as well as a few other settings.

Once you understand the basic concept of managing configuration files with Puppet,
you easily expand on this patterh to manage more complex configurations for other packages.

I already created a `files` directory inside the `pasture` module directory.
Just like placing manifests inside a module's `manifests` directory allows Puppet
to find the classes they define, placing files in the module's `files` directory
makes them available to Puppet.

<div class = "lvm-task-number"><p>Task 8:</p></div>

I'll create a `pasture_config.yaml` file in my module's `files` directory.

    vim pasture/files/pasture_config.yaml

Here, I'll set the default character to `elephant`. Remember, the actual details
of how a configuration file looks are specific to the package you're using,
not defined by Puppet itself. The pasture uses a yaml file for configuration,
so that's what I'll set up here.

```yaml
---
:default_character: elephant
```

With this source file saved to my module's `files` directory, I can now use
it to define the content of a `file` resource.

The `file` resource takes a `source` parameter, which lets me to specify a
source file for the content of the managed file. As its value,
this parameter takes the URI of the file I want to use. While it's possible to point to other locations,
this URI typically a file in the module's `files` directory, such as the pasture_config.yaml
file I just created.
Puppet uses a shortened URI format that begins with the `puppet:` prefix to
refer to these module files kept on the Puppet master. This format follows the
pattern `puppet:///modules/<MODULE NAME>/<FILE PATH>`. Notice the triple
forward slash just after `puppet:`. This stands in for the implied path to the
modules on my Puppet master.

Don't worry if this URI syntax seems complex. It's pretty rare that you'll need
to use it for anything other than referring to files within your modules, so
the pattern above is likely all you'll need to learn. You can always refer back
to the Puppet docs for a reminder. I've included a link below the video to point
you in the right direction.

<div class = "lvm-task-number"><p>Task 9:</p></div>

I'll now return to my `init.pp` manifest and add a file resource declaration.

    vim pasture/manifests/init.pp


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

Before moving on, I'll check my syntax with the `puppet parser` tool.

    puppet parser validate pasture/manifests/init.pp

## Service

While the cowsay command I installed in the previous lesson runs once and
exits, Pasture is intended to be run as a service. This way, a Pasture process can run
in the background and listen for any incoming requests on its designated port.
Because my agent node is running CentOS 7, I'll use the systemd
service manager to handle this Pasture process.
Although some packages set up their own service unit files, Pasture does not,
so I'll have to use a `file` resource to create my own. This service unit
file will tell systemd how and when to start the Pasture application.

Setting up this service unit file will very similar to setting up the
configuration file. I'll first create the file in the module's files
directory, then create a file resource with a source parameter pointing
to the new file.

<div class = "lvm-task-number"><p>Task 10:</p></div>

I'll call this new file `pasture.service`.

    vim pasture/files/pasture.service

And I'll enter the configuration settings to describe how I want systemd
to manage this service.

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

Now I'll open the `init.pp` manifest again.

    vim pasture/manifests/init.pp

First, I'll add a file resource to manage my service unit file.
This will use the file I just created in the files directory as its
source, and will be end up in the `etc/systemd/system` directory on the
agent node where it's applied.

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

I'll open my `init.pp` manifest and add relationship metaparameters to define the dependencies among my
`package`, `file`, and `service` resources. 

    vim pasture/manifests/init.pp


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

I'll check my syntax one more time with the `puppet parser`
tool.

    puppet parser validate pasture/manifests/init.pp

The `pasture.puppet.vm` node is still classified with this `pasture` class,
so when I return to the node and do another puppet agent run, the master will
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

From the master, I'll use the `curl` command to retrieve an ASCII elephant from
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
