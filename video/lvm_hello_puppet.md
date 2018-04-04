# Hello Puppet

This video I’ll help you get started with the basics: What is Puppet and what
does it do? I’ll begin with a brief introduction to Puppet and it’s approach to
automation. Next, I’ll install the Puppet agent on a new system and use the
puppet resource tool to explore the state of that system. Through this tool,
you will learn about resources, the basic units that Puppet uses to describe
and manage a system.

I’ll walk you through these steps using the Puppet Learning VM. This will give
you a realistic view of what it’s like to work with Puppet through an
command-line session on a system where the software is installed. If you’d like
to follow along yourself, you can find a link in the notes below to the
Learning VM download page.

## Get started

Before getting started, I’ll run the quest begin command on the Learning VM to
set up the environment I’ll be using to demonstrate these concepts.

		quest begin hello_puppet

## What is Puppet?

Before getting into some of the fundamentals of how to use
Puppet, l’ll give you a quick overview of what Puppet is. This way you’ll have
a better sense of how each topic fits into the bigger picture. 

Puppet lets you to define a desired state for all the systems in your
infrastructure you want to manage. Once this state is defined, Puppet automates
the process of getting these systems into that state and keeping them there.

Puppet uses a domain-specific language called Puppet code to describe this
system state in a way that’s portable across all the devices and operating
systems you need to manage. This infrastructure as code approach opens the door
to a whole range of DevOps best practices such as version control, compliance
validation, continuous integration, and automated testing.

Puppet code is a declarative language, which means that you describe only the
desired state for your systems, not the steps needed to get there. Instead, you
rely on the Puppet agent to translate this desired state into commands that it
then executes with native system tools. The puppet agent also handles
communication with the Puppet master, the server that stores Puppet code
defining desired state for all your agent systems.

## The Puppet agent

For now, I'll set aside the agent's interactions with the Puppet master and
focus on the tools that Puppet uses to inspect and modify a system's state.

When you install the Puppet agent you get a set of command-line tools that help
you interact directly with a system in the same way the Puppet agent does.
Using these tools will help you understand how the Puppet agent sees and
modifies the state of the system where it's running.

## Agent installation

Though I'll be focusing on the local Puppet agent in this demonstration, I’ll
still be working in the context of the master-agent architecture set up on the
Learning VM demo environment. 

Task 1:

To get started, I’ll use ssh to connect to the agent node set up for this demo,
hello.puppet.vm. 

    ssh learning@hello.puppet.vm

Now that I’m connected to this system, I’ll need to install the Puppet agent.
The master server hosts an install script, so I can run a curl-bash command to
load the agent installer from the master and run it on my agent system:

   curl -k https://learning.puppetlabs.vm:8140/packages/current/install.bash | sudo bash

You can find full documentation of the agent installation process, including
specific instructions for other operating systems in the installation
documentation, which I’ll link to below this video.

## Resources

As I noted above, the Puppet agent comes with a set of supporting tools you can
use to explore your system from Puppet's perspective. Now that the agent is
installed, I’ll use these tools to demonstrate some of the key ways Puppet
interacts with the system it manages.

One of Puppet's core concepts is the resource abstraction layer. This refers to
a set of tools that Puppet uses to translate back and forth between the
resources defined in your Puppet code and the actual state of those resources
on a system. The term resource refers to a distinct unit of configuration on a
system, such as a user, file, service, package, or one of many other built-in
or user-defined resource types. The puppet resource tool lets you directly
interact with system resources through the same abstraction layer used by the
Puppet agent. Exploring a system with the puppet resource tool is will give you
a better idea of how Puppet can describe and interact with a system you want it
to manage. 

Task 2:

For example, I can ask Puppet to describe a file resource on my system by
specifying the type file and passing in the path of the file I want to look at:

    sudo puppet resource file /tmp/test

What you see is the Puppet code representation of this resource. In this case,
the resource's type is file, and its path is /tmp/test:

```
file { '/tmp/test':
  ensure => 'absent',
}
```

I’ll break down this resource syntax into its components so you can see the
anatomy of a resource a little more clearly.

```
type { 'title':
    parameter => 'value',
}
```

The resource’s type tells Puppet what kind of thing the resource describes and
points Puppet to the set of tools it will use to manage that resource on your
system.

The body of a resource is a list of parameter value pairs that follow the
pattern parameter => (an operator called a ‘hash rocket’), then the assigned
value. The parameters and possible values vary from type to type. The list of
parameter value pairs describes the state of the resource on the system. Full
documentation for resource parameters is provided in the Resource Type
Reference linked to below this video.

The resource title is a unique name that Puppet uses to identify the resource
internally. In the case of the file resource example, the resource's title is
the path of the file on the system: /tmp/test. Each resource type has a unique
identifying feature that the Puppet resource tool uses as the resource title
when it inspects that resource.

    sudo puppet resource user root

For example, A user resource uses the account name as a title, and a package
resource uses the name of the package.

Now that you're more familiar with the resource syntax, I’ll take another look
at that file resource.

sudo puppet resource file /tmp/test

```
file { '/tmp/test':
  ensure => 'absent',
}
```

Notice that it has a single parameter value pair: ensure => 'absent'. The
ensure parameter describes basic state of the resource. For the file type, this
parameter says whether file exists on the system and if it does, whether it's a
normal file, a directory, or a link.

Task 3:

So “ensure absent” is telling me that this file doesn't exist. Let's see what
happens when I use the touch command to create a new empty file at that path.

    touch /tmp/test ls /tmp/test

Now I’ll use the Puppet resource tool again to see how this change is
represented in Puppet's resource syntax:

    sudo puppet resource file /tmp/test

Now that the file exists on the system, Puppet has more to say about it. It
shows the ensure and content parameters and their values, plus information
about the file's owner, when it was created, and when it was last modified.

```
file { '/tmp/test':
  ensure  => 'file',
  content => '{md5}d41d8cd98f00b204e9800998ecf8427e',
  ...
}
```

The value of the content parameter might not be what you expected. When the
puppet resource tool interprets a file in this resource declaration syntax, it
converts the content to an MD5 hash. This hashing helps Puppet efficiently
compare the content of a file on your system against the expected content to
see if any change is necessary.

Task 4:

Next, I’ll use puppet resource tool to add some content to the /tmp/test file.

Running puppet resource with a parameter=value argument tells Puppet to modify
the resource on the system to match the value you set. You can use this to set
the content of your file resource.

    sudo puppet resource file /tmp/test content='Hello Puppet!'

The output you see shows Puppet checking the hash of the existing content
against the new content you provided. When it sees that the hashes don't match,
it sets the file's content to the value of the command's content parameter.

Now I can take a look at the file’s content to see the change.

    cat /tmp/test

## Types and Providers

This translation back and forth between the state of the system and Puppet's
resource syntax is the heart of Puppet's resource abstraction layer. To get a
better understanding of how this works, let's take a look at another resource
type, the package.

Task 5:

As an example, I'll look at the package for the Apache webserver httpd.

    sudo puppet resource package httpd

Because this package doesn't exist on the system, Puppet shows you the ensure
=> purged parameter value pair. This purged value is similar to the absent
value you saw earlier for the file resource, but in the case of the package
resource, it specifies that the package itself is absent and all associated
configuration files have been purged.

```
package { 'httpd':
  ensure => 'purged',
}
```

Each resource type has a set of providers. A provider is the translation layer
that sits between Puppet's resource representation and the native system tools
Pupet uses to inspect and modify the underlying system state. Each resource
type generally has a variety of different providers that can be used to manage
the resource through different system tools.

These providers can seem invisible when everything is working correctly, but
it's important to understand how they interact with the underlying tools.

The quickest way to see the inner workings of a provider is to break it. I’ll
Puppet to install a nonexistent package named bogus-package:

    sudo puppet resource package bogus-package ensure=present

The error message tells shows that  the yum package manager wasn't able to find
the specified package. It also shows the specific command that Puppet's yum
provider tried to run to install the package.

    Error: Execution of '/bin/yum -d 0 -e 0 -y install bogus-package' returned 1:

Error Nothing to do Puppet selects a default provider based on the agent's
operating system and whether the tools associated with that provider are
available. You can override this default by setting a resource's provider
parameter.

I’ll try installing the same bogus package, but, this time I’ll use the gem
provider:

    sudo puppet resource package bogus-package ensure=present provider=gem

Puppet outputs a similar error, but this time you can see that it tried to run
a gem command instead of a yum command:

```
Error: Execution of '/bin/gem install --no-rdoc --no-ri bogus-package' returned
2: ERROR:  Could not find a valid gem 'bogus-package' (>= 0) in any repository
Error: /Package[bogus-package]/ensure: change from absent to present failed:
Execution of '/bin/gem install --no-rdoc --no-ri bogus-package' returned 2:
ERROR:  Could not find a valid gem 'bogus-package' (>= 0) in any repository
```

Now that you have a better sense of how Puppet’s providers provide an interface
to system tools, I’ll install a real package with the default yum provider:

    sudo puppet resource package httpd ensure=present

This time, Puppet successfully installs the package and displays the new state
of the resource. The value of the ensure parameter now shows the specific
version of the installed package:

```
package { 'httpd':
    ensure => '2.4.6-45.el7.centos',
}
```

Because I didn’t specify a version of the package to install, Puppet defaulted
to installing latest available version.

Now that I’ve covered some of the basics of Puppet resources and the resource
abstraction layer using tools installed with the Puppet agent, I’ll exit to
return to the Puppet master so I can pick up from there in the next lesson.

    exit

## Review

In this video, we started with an overview of Puppet, declarative
domain-specific language and master-agent architecture.

I installed the Puppet agent on a new system using an install script hosted on
the Puppet master. Once the agent and suite of supporting tools were installed,
you learned the fundamentals of Puppet's resource abstraction layer, including
resources, resourcetypes, and the providers that translate between your Puppet
code and the native system tools.

In the next video, I’ll go into some of the details of how Puppet takes
advantage of this resource abstraction layer to define a desired state and
automate the process of enforcing this state on the systems you want to manage.
