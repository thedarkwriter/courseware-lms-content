{% include '/version.md' %}

# Conditional Statements

In this video, I'll discuss **conditional statements.** Conditional statements let
you write Puppet code that behaves differently in different contexts. I'll 
show how to use conditional statements to write flexible Puppet code, explain the syntax 
of the `if` statement, and show how to use an `if` statement to intelligently
manage a package dependency.

## Getting started

To start this lesson, I'll use the quest command to set up the environment on the Learning VM:

    quest begin conditional_statements

## Writing for flexibility

Because Puppet manages configurations on a variety of systems fulfilling a
variety of roles, good Puppet code means flexible and portable Puppet code.
Though Puppet's *types* and *providers* can translate between Puppet's resource
syntax and the native tools on a wide variety of systems, there are still a lot
questions answer yourself as you write Puppet code.

A good rule of thumb is that the resource abstraction layer can figure out
**how** to do something, while the Puppet code you write must clearly specify
**what** you want to be done.

As an example, let's take a look at the `puppetlabs-apache` module. While this
module's developers rely on Puppet's providers to determine how the Apache
package is installed—whether it's handled by `yum`, `apt-get` or another
package manager—Puppet doesn't have any way of automatically determining the
name of the package that needs to be installed. Depending on whether the module
is used to manage Apache on a RedHat or Debian system, it will need to manage
either the `httpd` or `apache2` package. The information needed to make this
kind of decision needs to be provided by the module developer.

This kind of **what** question is often addressed through a combination of
conditional statements, facts, and parameters. If you look at the
`puppetlabs-apache` module on the Forge, you'll see this package name and
numerous other variables set based on an `if` statement using the `osfamily`
fact. You may notice that this module uses an un-structured `$::osfamily`
format for this fact to preserve backwards compatibility. You can read more
about this form of reference on the docs page linked below this video.

Simplified to show only the values we're concerned with, the conditional
statement looks like this:

```puppet
if $::osfamily == 'RedHat' {
  ...
  $apache_name = 'httpd'
  ...
} elsif $::osfamily == 'Debian' {
  ...
  $apache_name = 'apache2'
  ...
}
```

Here, the `$apache_name` variable is set to either `httpd` or `apache2`
depending on the value of the `$::osfamily` fact. Elsewhere in the module,
you'll find a package resource that uses this `$apache_name` variable
to set its `name` parameter.

```puppet
package { 'httpd':
  ensure => $ensure,
  name   => $::apache::apache_name,
  notify => Class['Apache::Service'],
}
```

Also, note that because the `name` parameter is being explicitly set here, the
resource *title* (`httpd`) only serves as an internal identifier for the
resource—it doesn't actually determine the name of the package that will be
installed. This distinction between the resource title and the namevar can be
a little confusing. If you're not clear on this, I'd suggest taking a look at the
discussion of the topic in the Puppet docs, which I've linked to below.

## Conditions

Now that you've seen this real-world example of how and why a conditional
statement can be used to create more flexible Puppet code, I'll take a moment
to discuss how these statements work and how to write them. 

Conditional statements return different values or execute different blocks of
code depending on the value of a specified variable.

Puppet supports a few different ways of implementing conditional logic:
 
 * `if` statements,
 * `unless` statements,
 * case statements, and
 * selectors.

Because the same concept underlies these different forms of conditional logic
available in Puppet, I'll only cover the `if` statement in the tasks for this
lesson. Once you have a good understanding of how to implement `if` statements,
I'll leave you with descriptions of the other forms and some notes on when you
may find them useful.

An `if` statement includes a condition followed by a block of Puppet code that
will only be executed **if** that condition evaluates as **true**. Optionally,
an `if` statement can also include any number of `elsif` clauses and an `else`
clause.

- If the `if` condition fails, Puppet moves on to the `elsif` condition (if one
  exists).
- If both the `if` and `elsif` conditions fail, Puppet will execute the code in
  the `else` clause (if one exists).
- If all the conditions fail, and there is no `else` block, Puppet will do
  nothing and move on.

## Pick a server

Let's return to my Pasture example module. The Pasture application is built on the
Sinatra framework, a simple framework for writing web applications in Ruby. Out of
the box, Sinatra supports a few different options for the server the service will
run: WEBrick, Thin, or Mongrel. In production, I would likely use Sinatra with a
more robust option such as Passenger or Unicorn, but these built-in options will be
adequate for this lesson. As before, as long as you understand the basic concept
of Puppet conditionals by the end of the lesson, don't worry if you're not familiar
with the specifics of the software I'm using as an example in this lesson.

I can easily select which server will be used in the Pasture application's
configuration file. However, only the WEBrick server is installed by default
with the Pasture package. To use these other options, I'll need my module to
manage them as distinct `package` resources.  However, I don't want to waste space
by installing extra packages if I don't plan on using them. Using the `if` statement
discussed above, I'll configure the `pasture` class to manage a Thin
or Mongrel package resource only if one of these servers is selected.

While the Apache example I showed above used an osfamily fact to automatically
determine the package to be used, I'm restricted in my environment to a single
operating system, so I'll be setting the desired package directly through a
class parameter.

I can use the same parameter to pass the name of my selected server Pasture
configuration file template and to decide which additional packages need to
be installed. Using parameters in this way helps keep configuration coordinated
across all the components of the system my module is written to manage.

<div class = "lvm-task-number"><p>Task 1:</p></div>

I'll open the module's `init.pp` manifest.

    vim pasture/manifests/init.pp

First, I'll add a `$sinatra_server` parameter with a default value of `webrick`.

```puppet
class pasture (
  $port              = '80',
  $default_character = 'sheep',
  $default_message   = '',
  $config_file       = '/etc/pasture_config.yaml',
  $sinatra_server    = 'webrick',
){
```

Next I'll add the `$sinatra_server` variable to the `$pasture_config_hash` so that
it can be passed through to the configuration file template.

```puppet
  $pasture_config_hash = {
    'port'              => $port,
    'default_character' => $default_character,
    'default_message'   => $default_message,
    'sinatra_server'    => $sinatra_server,
  }
```

<div class = "lvm-task-number"><p>Task 2:</p></div>

Once that's complete, I'll open the `pasture_config.yaml.epp` template.

    vim pasture/templates/pasture_config.yaml.epp

Here, I'll add the `$sinatra_server` variable to the params block at the beginning of the
template. The Pasture application passes any settings under the `:sinatra_settings:`
key to Sinatra itself, so I can use this configuration file to set Sinatra's server
by passing in the value of the sinatra server variable here.

```yaml
<%- | $port,
      $default_character,
      $default_message,
      $sinatra_server,
| -%>
# This file is managed by Puppet. Please do not make manual changes.
---
:default_character: <%= $default_character %>
:default_message:   <%= $default_message %>
:sinatra_settings:
  :port:   <%= $port %>
  :server: <%= $sinatra_server %>
```

Now that my module is able to manage this setting, I'll add a conditional
statement to manage the required packages for the Thin and Mongrel
webservers.

<div class = "lvm-task-number"><p>Task 3:</p></div>

I'll return to my `init.pp` manifest to add this conditional.

    vim pasture/manifests/init.pp

First, I'll create a conditional block. Remember, I only need to install
a package **if** i've specified thin or mongrel as the value of the sinatra_server
parameter. Once I've determined that a webserver package needs to be managed,
I can pass in this parameter value directly to identify which webserver package
this resource should manage.

Both of these servers are published as Ruby gems, so I'll use the `gem`
provider for the package.

Finally, I'll add a `notify` parameter pointing to my service resource.
This will ensure that the server package is managed before the service, and
that any changes Puppet makes to the package will trigger a restart of
the service.

```puppet
class pasture (
  $port                = '80',
  $default_character   = 'sheep',
  $default_message     = '',
  $pasture_config_file = '/etc/pasture_config.yaml',
  $sinatra_server      = 'webrick',
){

  package { 'pasture':
    ensure   => present,
    provider => 'gem',
    before   => File[$pasture_config_file],
  }

  $pasture_config_hash = {
    'port'              => $port,
    'default_character' => $default_character,
    'default_message'   => $default_message,
    'sinatra_server'    => $sinatra_server,
  }

  file { $pasture_config_file:
    content => epp('pasture/pasture_config.yaml.epp', $pasture_config_hash),
    notify  => Service['pasture'],
  }

  $pasture_service_hash = {
    'pasture_config_file' => $pasture_config_file,
  }

  file { '/etc/systemd/system/pasture.service':
    content => epp('pasture/pasture.service.epp', $pasture_service_hash),
    notify  => Service['pasture'],
  }

  service { 'pasture':
    ensure    => running,
  }

  if $sinatra_server == 'thin' or 'mongrel'  {
    package { $sinatra_server:
      provider => 'gem',
      notify   => Service['pasture'],
    }
  }

}
```

With these changes to my class, I can easily accommodate different servers
for different agent nodes in my infrastructure. For example, I may want to
use the default WEBrick server on a development system and the Thin server
for production.

The quest tool created two systems for this lesson: `pasture-dev.puppet.vm` and
`pasture-prod.puppet.vm`. For a more complex infrastructure, I would likely
manage my development, test, and production segments of my infrastructure
by creating a distinct environment for each. For now, however, I can easily 
demonstrate our conditional statement by setting up two different node 
definitions in the `site.pp` manifest.

<div class = "lvm-task-number"><p>Task 4:</p></div>

    vim /etc/puppetlabs/code/environments/production/manifests/site.pp

```puppet
node 'pasture-dev.puppet.vm' {
  include pasture
}
node 'pasture-prod.puppet.vm' {
  class { 'pasture':
    sinatra_server => 'thin',
  }
}
```

## The puppet job tool

Now that I'm working across multiple nodes, connecting manually with SSH to
trigger Puppet runs may start to seem a little tedious. The `puppet job` tool
lets me trigger Puppet runs across multiple nodes remotely.

<div class = "lvm-task-number"><p>Task 5:</p></div>

Before using this tool, I'll have to take a few steps via the PE console to set
up authentication through PE's role-based access control system (RBAC). This will
be a bit of a digression, so if you're only interested in conditionals, feel free
to skip ahead.

To log in to the console, I'll bring up a web browser on the host system where
I'm running the Learning VM and navigate to `https://<VM's IPADDRESS>`. (Note
that using `https` takes me to the console, while `http` would take me to a
text version of these lessons, which is also hosted on the Learning VM.

At this point, I'll see a warning from my browser that the PE console is using a
self-signed certificate. I can safely ignore this warning and proceed to the
PE console login page.

I'll log in with the credentials set up for the Learning VM, admin and puppetlabs

Username: **admin**
Password: **puppetlabs**

Once I've connected, I'll click the **access control** menu option in the
navigation bar at near the bottom left of the screen, and then select **Users**
in the *Access Control* navigation menu.

I'll create a new user with the **Full name** `Learning` and **Login** `learning`.
Next, I'll need to set up a password for this user. I'll click on the name of the new user
and find the **Generate password reset** link. I'll follow the given link and set
the password to: **puppet**.

Now that I have a new user set up, I'll need to give this user operator permissions
to trigger puppet runs.

Under the **Access Control** navigation bar, I'll find the **User Roles** menu
option and the **Operators** role. I'll select the **Learning**
user from the dropdown menu, click the **Add user** button, and finally click
the **Commit 1 change** botton near the bottom right of the console screen.

With this user configured, I can use the `puppet access` command to generate
a token that will allow me to use the `puppet job` tool. I'll set the
lifetime for this token to one day so I won't have to worry about
re-authenticating as I work.

    puppet access login --lifetime 1d

I'll supply the credentials I set up above: username **learning** and password **puppet**.

Now I can trigger Puppet agent runs on `pasture-dev.puppet.vm` and
`pasture-prod.puppet.vm` with the `puppet job` tool. I provide the names of
the two nodes in a comma-separated list after the `--nodes` flag. (Note that
there's no space between the node names.)

    puppet job run --nodes pasture-dev.puppet.vm,pasture-prod.puppet.vm

When the jobs complete, I can check each with a `curl` command.

    curl 'pasture-dev.puppet.vm/api/v1/cowsay?message=Hello!'

and

    curl 'pasture-prod.puppet.vm/api/v1/cowsay?message=Hello!'

To verify that each system is running the server I specified, I'll log
in and use the `journalctl` command to check the service's startup log.

    ssh learning@pasture-dev.puppet.vm

    journalctl -u pasture

    exit

    ssh learning@pasture-prod.puppet.vm

    journalctl -u pasture

Now that I've verified that each node is running the expected server,
I'll disconnect to return to the master.

    exit

## Review

In this lesson, I showed how conditional statements can help make the code
you write for a Puppet module adaptable to cover different conditions. I showed 
an example of how the `puppetlabs-apache` module uses a conditional statement
to install a different package depending on the node's operating system. After
explaining the syntax of the `if` statement, I incorporated a conditional
statement into my `pasture` module to help manage the package dependencies
for the different server options available to the Sinatra framework.

So far, the `pasture` and `motd` modules I've used have been written from
scratch. This is great for the sake of learning, but one of Puppet's strengths
lies in the Puppet community and the Puppet Forge—the repository of pre-written
modules that can easily be incorporated into your own Puppet codebase. In the next
video, I'll show how to make use of an existing module to set up a database
backend for the Pasture application.
