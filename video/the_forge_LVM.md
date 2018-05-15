{% include '/version.md' %}

# The Forge

In this video, I'll introduce the Puppet Forge, a repository for modules
written and maintained by Puppet and the Puppet community. I'll show how to find a 
module on the Forge and create a wrapper class to integrate it into your own
module. You'll see how the flexible parameters of classes found in Forge modules
let you easily adapt a broad base of existing Puppet code to your own needs.

## Getting started

Before gettins started, I'll use the quest begin command to set up the envronment
for this lesson.

    quest begin the_forge

## What is the Forge?

The Puppet Forge is a public repository for Puppet modules
contributed and maintained by Puppet and the Puppet community. Using existing
modules from the Forge lets you to manage a wide variety of system components
without spending extensive time on custom module development. Furthermore,
because many Forge modules are actively used and maintained by the Puppet
community, you'll be working with code that's already well reviewed and tested.
By using Forge modules with an active community of users and maintainers, you can
greatly reduce your own team's burden of development, testing, and maintenance.

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
database and later retrieve them by a numerical ID.

To support this feature, I'lll need to set up a database server, then create
and configure a database instance with the correct user and permissions so
my application can connect.

Creating a module from from scratch would be quite time consuming, so I'll look
for a the PostgreSQL module from the Forge to help out. I can use the search
interface on the Forge website to do a search for `PostgreSQL`.

(Search for postgresql on the Forge)

The Forge will show several hits that match my query, including version and
release data information, downloads, a composite rating score, and a supported
or approved banner where relevant. This information gives me a quick idea
of which modules in the search results I may want to investigate further.

For this lesson, I'll use the `puppetlabs/postgresql` module. Once I click on that
module title, I see more information and documentation.

(Click on module link)

## Installation

Recall that a module is just a directory structure containing Puppet manifests
and any other code or data the module needs to do its job. The Puppet master finds
any modules in its *modulepath* directories and uses the module directory
structure to find the classes, files, templates, and whatever else the module provides.

Installing a module means placing the module directory into the Puppet master's
modulepath. While I could download the module and manually move it to the
modulepath, Puppet provides tools to manage installing a module and its
dependencies.

There are two different methods of installation mentioned near the top of the
`postgresql` module: the Puppetfile and the `puppet module` tool. For this
lesson, I'll use the simpler `puppet module` tool. As you start managing a
more complex Puppet environment and checking your Puppet code into a control
repository, however, using a Puppetfile is recommended. You can read more about
the Puppetfile and code management workflow at the link on the page below this video,
and find content in the Learning VM guide what will walk you through this topic.

<div class = "lvm-task-number"><p>Task 1:</p></div>

On my master, I'll use the `puppet module` tool to install the puppetlabs-postgresql
module.

    puppet module install puppetlabs-postgresql --version 4.9.0

To confirm that this command placed the module in my modulepath, I can look
at the contents of my modules directory.

    ls /etc/puppetlabs/code/environments/production/modules

Notice that when I saw the module on the Forge, it was listed as
`puppetlabs/postgresql`, and when I installed it, I called it
`puppetlabs-postgresql`, but the actual directory where it installed is
`postgresql`. The `puppetlabs` corresponds to the name of the Forge user
account that uploaded the module to the Forge. This distinguishes modules
with the same name created and published by different users.

When a module is installed, however this account name is not
included in the module directory name, meaning that you cannot install
multiple modules with the same name without causing conflicts, even if
those modules are listed under a different name on the Forge.

To see a full list of modules installed in all modulepaths on my master, I can use
the `puppet module` tool's `list` subcommand.

    puppet module list
    
Notice that when I installed the postgresql module, the Puppet module tool
also identified and installed several pre-requisites: standardlib, apt, and
concat.

## Writing a wrapper class

With the `postgresql` module installed, I can add now add database component to the
Pasture module without writing all the Puppet code needed to manage
a PostgreSQL server and database instance. I'll create what's called
a *wrapper class* to declare classes from the `postgresql` module within
my pasture module and set their parameters according to my needs for the
Pasture application.

<div class = "lvm-task-number"><p>Task 2:</p></div>

I'll call this wrapper class `pasture::db` and define it in a `db.pp` manifest
in the `pasture` module's `manifests` directory.

    vim pasture/manifests/db.pp

Within this `pasture::db` class, I'll use the classes provided by the
`postgresql` module to create a postgres server, set up a database
instance called `pasture`, and configure a host based authentication
(or HBA) rule to allow access to this database from the server running my
Pasture application. 

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
The specifics of how each of these elements relates
the the underlying database configuration are documented on the PostgreSQL
module's Forge page. Generally, if you're familiar with the steps involved
in manually configuring a component, it's quite easy to refer to the documentation
of a related Forge module to see how those steps translate into Puppet code.
If you're more familiar with a different kind of database, or, for that matter,
have any component in mind that you'd be interested in automating with Puppet,
I'd suggest taking a look at the Forge after this video to see if you can find
a related module and have a look through its documentation.

Now that my wrapper class is done, I can easily add an entry for my database
server to node definition in my `site.pp` manifest. 

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

In this case, I've kept things simple and created a wrapper class
without parameters, so I'll use the `include` syntax to add this
class to my node definition. Note that if I later wanted an option
to pass any parameters through to the postgresql class, I could easily
add parameters to the wrapper class and change this `include` statement
to a resource-like class declaration.

Next, I'll use the `puppet job` tool to trigger a Puppet agent run on this
`pasture-db.puppet.vm` node.

    puppet job run --nodes pasture-db.puppet.vm

Now that this database server is set up, I'll need to tell my application
server how to connect to it. I'll add a parameter to my main
pasture class to specify the database URI, then pass this URI through
to the application's configuration file through the template that defines
that file.

<div class = "lvm-task-number"><p>Task 4:</p></div>

I'll open my module's `init.pp` manifest.

    vim pasture/manifests/init.pp

First, I'll add a `$db` parameter with a default value of `'none'`.
I'll now add this `$db` variable to the `$pasture_config_hash` so it
will be passed through to the template that defines the application's
configuration file.

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
`none` set for the `$db` variable. Note that there's nothing special about this
`none` value—it's just a string that makes it easy to see whether a URI
has been provided to the class.

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

Now that I've set up this `db` parameter, I'll edit my
`pasture-app.puppet.vm` node definition.

    vim /etc/puppetlabs/code/environments/production/manifests/site.pp

I'll declare the `pasture` class and set the `db` parameter to the URI of the
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
I can now add new messages to the application's database and retrieve them by
ID. Let's give it a try.

First, I'll post the message 'Hello!' to my database.

    curl -X POST 'pasture-app.puppet.vm/api/v1/cowsay/sayings?message=Hello!'

Now I can query the list of available messages:

    curl 'pasture-app.puppet.vm/api/v1/cowsay/sayings'

Finally, I can retrieve a message by ID:

    curl 'pasture-app.puppet.vm/api/v1/cowsay/sayings/1'

## Review

In this quest, I showed how to incorporate classes provided by a module from
the Forge into your own module to allow it to manage a database. I began by
covering the Forge website and its search features that help you find the right
module for your project.

After finding a good module, I used the `puppet module` tool to install it
into my `modules` directory. With the module installed, I created a
`pasture::db` wrapper class to define the specific database functionality I needed
for the Pasture application, and updated the main `pasture` class to define
the URI needed to connect to the database.

With this new `pasture::db` wrapper class set up and the `db` parameter added to the
main pasture class, a few changes to my `site.pp` classification let me
create a database server and connect it to my application server.

For now, this is the final video in the series we're recording to accompany
the Learning VM. If you're following along on your own Learnign VM, you can continue
following the Quest Guide to complete the remaining content on the Learning VM. This
content covers topics such as Hiera, a tool used to separate data from your manifests,
and the Control Repository setup and workflow you can use to manage changes to your
Puppet infrastruture with a git source control workflow.

I'd also suggest that you check out our free self-paced courses and catalog of
Instructor-led online and classroom trainings. The self-paced courses are generally
shorter in length than these videos so they can give a more focused overview of each
topic. Our instructor-led courses give you a chance to learn live from one of our
Professional Services Engineers, and try things out hands-on in a live lab environment.
I'll post links to our training page in the comments below.

Thanks for taking the time to look into Puppet and watch this video. I hope this
gives you a good start to using Puppet, and that Puppet can make your life a little
easier!
