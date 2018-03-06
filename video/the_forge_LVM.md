{% include '/version.md' %}

# The Forge

In this video, we'll introduce you to the Forge, a repository for modules
written and maintained by the Puppet community. I'll show how to find a 
module on the Puppet Forge. Then I'll walk through using class parameters to 
adapt a Forge module to your needs and creating a wrapper class to integrate 
a Forge module into your own module.

## Getting started

I'll enter the following command to get started:

    quest begin the_forge

## What is the Forge?

The Puppet Forge is a public repository for Puppet modules
that gives you access to community maintained modules. Using existing
modules from the Forge allows you to manage a wide variety of applications and systems
without spending extensive time on custom module development. Furthermore,
because many Forge modules are actively used and maintained by the Puppet
community, you'll be working with code that's already well reviewed and tested.
The more users who are involved with a module, the less maintenance and
testing burden you and your team will have to take on.

For those who put a high premium on vetted code and active maintenance, the
Forge maintains lists of modules that have been checked against standards set
by Puppet's Forge team. Modules in the Puppet Approved category are audited to ensure
quality, reliability, and active development. Modules in the Puppet
Supported list are covered by Puppet Enterprise support
contracts and are maintained across multiple platforms and versions
over the course of the Puppet Enterprise release lifecycle.

So far, I've been using the Pasture application's API to return an ASCII cow
character with a message in her speech bubble. The application has another
feature I haven't mentioned yet: the ability to store custom messages in a
database and retrieve them by ID. By default, Pasture uses a simple SQLite
database to store these messages, but it can be configured to connect to an
external database.

In this lesson, I'll use a PostgreSQL module from the Forge to configure a
database the Pasture application can use to store and retrieve cow messages.

My first step will be to find an appropriate module to use. I can use the search
interface on the Forge website to do a search for `PostgreSQL`.

The Forge will show several hits that match my query, including version and
release data information, downloads, a composite rating score, and a supported
or approved banner where relevant. This information gives me a quick idea
of which modules in the search results I may want to investigate further.

For this lesson, I'll use the `puppetlabs/postgresql` module. Once I click on that
module title, I see more information and documentation.

To set up a database for the Pasture application, I will need to set up a
database server and create and configure a database instance with the correct
user and permissions. 

## Installation

Recall that a module is just a directory structure containing Puppet manifests
and any other code or data needed to manage whatever it is the module helps
manage on a system. The Puppet master finds any modules in its *modulepath*
directories and uses the module directory structure to find the classes, files,
templates, and whatever else the module provides.

Installing a module means placing the module directory into the Puppet master's
modulepath. While I could download the module and manually move it to the
modulepath, Puppet provides tools to help manage my modules.

There are two different methods of installation mentioned near the top of the
`postgresql` module: the Puppetfile and the `puppet module` tool. For this
lesson, I'll use the simpler `puppet module` tool. As you start managing a
more complex Puppet environment and checking your Puppet code into a control
repository, however, using a Puppetfile is recommended. You can read more about
the Puppetfile and code management workflow at the link on the page below this video.

<div class = "lvm-task-number"><p>Task 1:</p></div>

On my master, I'll use the `puppet module` tool to install this
module.

    puppet module install puppetlabs-postgresql --version 4.9.0

To confirm that this command placed the module in my modulepath, I look
at the contents of my modules directory.

    ls /etc/puppetlabs/code/environments/production/modules

Notice that when I saw the module on the Forge, it was listed as
`puppetlabs/postgresql`, and when I installed it, I called it
`puppetlabs-postgresql`, but the actual directory where it installed is
`postgresql`. The `puppetlabs` corresponds to the name of the Forge user
account that uploaded the module to the Forge. This distinguishes different
users' versions of a module while browsing the Forge and during
installation. When a module is installed, this account name is not
included in the module directory name. Not knowing this could
cause some confusion; identically named modules will conflict if
they are installed on the same master.

To see a full list of modules installed in all modulepaths on my master, I use
the `puppet module` tool's `list` subcommand.

    puppet module list

## Writing a wrapper class

Using the existing `postgresql` module, I can add a database component to the
Pasture module without having to reinvent the Puppet code needed to manage
a PostgreSQL server and database instance. Instead, I'll create what's called
a *wrapper class* to declare classes from the `postgresql` module with
the parameters needed by the Pasture application.

<div class = "lvm-task-number"><p>Task 2:</p></div>

I'll call this wrapper class `pasture::db` and define it in a `db.pp` manifest
in the `pasture` module's `manifests` directory.

    vim pasture/manifests/db.pp

Within this `pasture::db` class, I'll use the classes provided by the
`postgresql` module to set up the `pasture` database that
will keep track of my cow sayings.

```puppet
class pasture::db {

  class { 'postgresql::server':
    listen_addresses => '*',
  }

  postgresql::server::db { 'pasture':
    user     => 'pasture',
    password => postgresql_password('pasture', 'm00m00'),
  }

  postgresql::server::pg_hba_rule { 'allow pasture app access':
    type        => 'host',
    database    => 'pasture',
    user        => 'pasture',
    address     => '172.18.0.2/24',
    auth_method => 'password',
  }

}
```

With this wrapper class done, I can easily add the database server it defines
to a node definition in my `site.pp` manifest. In this case, I've kept
things simple and created a class without parameters. As needed, I might add
parameters to this wrapper class in order to pass values through to the
postgresql classes it contains.

<div class = "lvm-task-number"><p>Task 3:</p></div>

I'll now open my `site.pp` manifest.

    vim /etc/puppetlabs/code/environments/production/manifests/site.pp

And I create a node definition to classify the `pasture-db.puppet.vm` node with
the `pasture::db` class.

```puppet
node 'pasture-db.puppet.vm' {
  include pasture::db
}
```

I use the `puppet job` tool to trigger a Puppet agent run on this
`pasture-db.puppet.vm` node.

    puppet job run --nodes pasture-db.puppet.vm

Now that this database server is set up, I'll add a parameter to my main
pasture class to specify a database URI and pass this through to the
configuration file.

<div class = "lvm-task-number"><p>Task 4:</p></div>

I open my module's `init.pp` manifest.

    vim pasture/manifests/init.pp

And add a `$db` parameter with a default value of `'none'`. I'll show why we use
`'none'` a little later. Add this `$db` variable to the `$pasture_config_hash`
so it will be passed through to the template that defines the application's
configuration file. When I've made these two additions, my class will
look like the example below.

```puppet
class pasture (
  $port                = '80',
  $default_character   = 'sheep',
  $default_message     = '',
  $pasture_config_file = '/etc/pasture_config.yaml',
  $sinatra_server      = 'webrick',
  $db                  = 'none',
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
    'db'                => $db,
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

<div class = "lvm-task-number"><p>Task 5:</p></div>

Next, I'll edit the `pasture_config.yaml.epp` template. I'll use a conditional
statement to only include the `:db:` setting if there is a value other than
`none` set for the `$db` variable.

```puppet
<%- | $port,
      $default_character,
      $default_message,
      $sinatra_server,
      $db,
| -%>
# This file is managed by Puppet. Please do not make manual changes.
---
:default_character: <%= $default_character %>
:default_message: <%= $default_message %>
<%- if $db != 'none' { -%>
:db: <%= $db %>
<%- } -%>
:sinatra_settings:
  :port:   <%= $port %>
  :server: <%= $sinatra_server %>
```

Now that I've set up this `db` parameter, I will edit my
`pasture-app.puppet.vm` node definition.

    vim /etc/puppetlabs/code/environments/production/manifests/site.pp

I declare the `pasture` class and set the `db` parameter to the URI of the
`pasture` database I'm running on `pasture-db.puppet.vm`.

```puppet
node 'pasture-app.puppet.vm' {
  class { 'pasture':
    sinatra_server => 'thin',
    db             => 'postgres://pasture:m00m00@pasture-db.puppet.vm/pasture',
  }
}
```

<div class = "lvm-task-number"><p>Task 6:</p></div>

I use the `puppet job` tool to trigger an agent run on this node.

    puppet job run --nodes pasture-app.puppet.vm

With my database server set up and my application server connected to it,
I can now add sayings to the application's database and retrieve them by
ID. Let's give it a try.

First, I'll post the message 'Hello!' to my database.

    curl -X POST 'pasture-app.puppet.vm/api/v1/cowsay/sayings?message=Hello!'

Now let's take a look at the list of available messages:

    curl 'pasture-app.puppet.vm/api/v1/cowsay/sayings'

Finally, I retrieve a message by ID:

    curl 'pasture-app.puppet.vm/api/v1/cowsay/sayings/1'

## Review

In this quest, I showed how to incorporate a module from the Forge into your
module to allow it to manage a database. I began by covering the Forge website
and its search features that help you find the right module for your project.

After finding a good module, I used the `puppet module` tool to install it
into my `modules` directory. With the module installed, I created a
`pasture::db` class to define the specific database functionality I needed
for the Pasture application, and updated the main `pasture` class to define
the URI needed to connect to the database.

With this new `pasture::db` class set up and the `db` parameter added to the
main pasture class, a few changes to my `site.pp` classification let me
create a database server and connect it to my application server.

