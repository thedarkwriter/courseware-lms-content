{% include '/version.md' %}

# Variables and templates

## Getting started

In this lesson, I'll introduce variables and templates, show how to create an EPP template, and 
use the hash syntax to pass variables to an EPP template. Once a variable is assigned a
value in a Puppet manifest, the variable can be used throughout
the manifest to yield the assigned value. Through templates, these variables can
be incorporated into the content of any files a Puppet
manifest manages.

While it's convenient to introduce variables and templates here as a pair,
variables are used along with many of Puppet's other features to help write adaptable
Puppet code.

To get started, I enter the following command:

    quest begin variables_and_templates

## Variables

Variables allow a value to be bound to a name, which can then be used later
in the manifest.

A variable name is prefixed with a `$` (dollar sign), and a value is assigned
with the `=` operator. Assigning a short string to a variable, for example,
looks like this:

```puppet
$my_variable = 'look, a string!'
```

Once I have defined a variable, I can use it anywhere in my manifest where
I want to use the assigned value. Note that variables are parse-order
dependent, which means that a variable must be defined before it can be used.
Trying to use an undefined variable will result in a special `undef` value.
Though this may result in explicit errors, in some cases it will still lead
to a valid catalog with unexpected contents.

Puppet variables are technically *constants* from the perspective of
the Puppet parser as it parses Puppet code to create a catalog. Once a
variable is assigned, the value is fixed and cannot be changed. Here, the
*variability* refers to the fact that a variable can have a different
value set across different Puppet runs or across different systems in my
infrastructure.

<div class = "lvm-task-number"><p>Task 1:</p></div>

I'll start by setting up a few variables. I'll define the default
character the cowsay application will use, the port we want to service to
run on, and path of the configuration file.

First I open my `init.pp` manifest.

    vim pasture/manifests/init.pp

I assign these variables at the top of my class. Replace the hard-coded
references to the `/etc/pasture_config.yaml` configuration filepath with the
variable.

```puppet
class pasture {

  $port                = '80'
  $default_character   = 'sheep'
  $default_message     = ''
  $pasture_config_file = '/etc/pasture_config.yaml'

  package { 'pasture':
    ensure   => present,
    provider => 'gem',
    before   => File[$pasture_config_file],
  }
  file { $pasture_config_file:
    source  => 'puppet:///modules/pasture/pasture_config.yaml',
    notify  => Service['pasture'],
  }
  file { '/etc/systemd/system/pasture.service':
    source => 'puppet:///modules/pasture/pasture.service',
    notify  => Service['pasture'],
  }
  service { 'pasture':
    ensure    => running,
  }
}
```

I haven't yet done anything with the `$pasture_port` or `$default_character`
variables. To use these, I need a way to pass them into our configuration
file. I'll also need to pass the `$pasture_config_file` variable to my
service unit file so the service will start my Pasture process with the
configuration file I specify if I change it to something other than the default.

## Templates

Many of the tasks involved in system configuration and administration come down
to managing the content of text files. The most direct way to handle this is
through a templating language. A template is similar to a text file but offers
a syntax for inserting variables as well as some more advanced language
features like conditionals and iteration. This flexibility lets me manage a
wide variety of file formats with a single tool.

The limitation of templates is that they're all-or-nothing. The template must
define the entire file I want to manage. If I need to manage only a single
line or value in a file because another process or Puppet module will manage a
different part of the file, I could use Augeas, concat, or the file_line resource
type. Links for all of these are on the page below this video.

## Embedded Puppet templating language

Puppet supports two templating languages, Embedded Puppet
(EPP) and Embedded Ruby (ERB).

EPP templates were released in Puppet 4 to provide a Puppet-native templating
language that would offer several improvements over the ERB templates that had
been inherited from the Ruby world. Because EPP is now the preferred method,
it's what I'll be using in this lesson. Once you understand the basics of
templating, however, you can easily use the ERB format by referring to the
documentation.

An EPP template is a plain-text document interspersed with tags that allow
me to customize the content.

<div class = "lvm-task-number"><p>Task 2:</p></div>

It will be easier to explain the syntax with a concrete example, so I'll create
a template to help manage Pasture's configuration file.

First, I'll need to create a `templates` directory in my `pasture` module.

    mkdir pasture/templates

Next, I create a `pasture_config.yaml.epp` template file.

    vim pasture/templates/pasture_config.yaml.epp

Best practice is to begin my EPP template with a *parameter tag*. This
declares which parameters my template will accept and allows me to set their
default values. A template will work without this tag, but explicitly declaring
my variables here makes my template readable and easier to
maintain.

It's also good practice to add a comment to the beginning of the file so
people who might come across it know that it's managed by Puppet, and any manual
changes they make will be reverted the next time Puppet runs. This comment is
intended to be included directly in the final file, so I need to use the
comment syntax native to the file format I'm working with.

Here's the beginning of my template. 

```
<%- | $port,
      $default_character,
| -%>
# This file is managed by Puppet. Please do not make manual changes.
```

Now I'll explain the details of the syntax. The bars (`|`) surrounding 
the list of parameters are a special syntax that
define the parameters tag. The `<%` and `%>` are the opening and closing tag
delimiters that distinguish EPP tags from the body of the file. Those hyphens
(`-`) next to the tag delimiters will remove indentation and whitespace
before and after the tag. This allows me to put this parameter tag at the
beginning of the file, for example, without the newline character after the
tag creating an empty line at the beginning of the output file.

Next, I'll use the variables I set up to define values for the port and
character configuration options.

```
<%- | $port,
      $default_character,
      $default_message,
| -%>
# This file is managed by Puppet. Please do not make manual changes.
---
:default_character: <%= $default_character %>
:default_message:   <%= $default_message %>
:sinatra_settings:
  :port: <%= $port %>
```

The `<%= ... %>` tags I use to insert variables into the file are called
*expression-printing tags*. These tags insert the content of a Puppet
expression, in this case the string values assigned to my variables.

Now that this template is set up, I'll return to my `init.pp` manifest
and see how to use it to define the content of a `file` resource.

First, I need to save my template file and exit Vim.

<div class = "lvm-task-number"><p>Task 3:</p></div>

Now I'll open my `init.pp` manifest.

    vim pasture/manifests/init.pp

The `file` resource type has two different parameters that can be used to
define the content of the managed file: `source` and `content`.

As I explained earlier, `source` takes the URI of a source file like the ones
we've placed in our module's `files` directory. The `content` parameter
takes a string as a value and sets the content of the managed file to that
string.

To set a file's content with a template, I'll use Puppet's built-in `epp()`
function to parse our EPP template file and use the resulting string as the
value for the `content` parameter.

This `epp()` function takes two arguments: First, a file reference in the
format `'<MODULE>/<TEMPLATE_NAME>'` that specifies the template file
to use. Second, a hash of variable names and values to pass to the
template.

To avoid cramming all my variables into the `epp()` function, I'll put them
in a variable called `$pasture_config_hash` just before the file resource.

```puppet
class pasture {

  $port                = '80'
  $default_character   = 'sheep'
  $default_message     = ''
  $pasture_config_file = '/etc/pasture_config.yaml'

  package { 'pasture':
    ensure   => present,
    provider => 'gem',
    before   => File[$pasture_config_file],
  }
  $pasture_config_hash = {
    'port'              => $port,
    'default_character' => $default_character,
    'default_message'   => $default_message,
  }
  file { $pasture_config_file:
    content => epp('pasture/pasture_config.yaml.epp', $pasture_config_hash),
    notify  => Service['pasture'],
  }
  file { '/etc/systemd/system/pasture.service':
    source => 'puppet:///modules/pasture/pasture.service',
    notify  => Service['pasture'],
  }
  service { 'pasture':
    ensure    => running,
  }
}
```

Now that that's set, I can repeat the process for the service unit file.

I'll save and exit my `init.pp` file.

<div class = "lvm-task-number"><p>Task 4:</p></div>

Rather than start from scratch, I can just copy the existing file to use as a base
for my template.

    cp pasture/files/pasture.service pasture/templates/pasture.service.epp

I'll open the file with Vim to templatize it.

    vim pasture/templates/pasture.service.epp

Now, I add my parameters tag and comment to the beginning of the file and set the
`--config_file` argument of the start command to the value of
`$pasture_config_file`

```
<%- | $pasture_config_file = '/etc/pasture_config.yaml' | -%>
# This file is managed by Puppet. Please do not make manual changes.
[Unit]
Description=Run the pasture service

[Service]
Environment=RACK_ENV=production
ExecStart=/usr/local/bin/pasture start --config_file <%= $pasture_config_file %>

[Install]
WantedBy=multi-user.target
```

<div class = "lvm-task-number"><p>Task 5:</p></div>

Now I'll return to my `init.pp` manifest.

    vim pasture/manifests/init.pp

And modify the file resource for my service unit file to use the template I
just created.

```puppet
class pasture {

  $port                = '80'
  $default_character   = 'sheep'
  $default_message     = ''
  $pasture_config_file = '/etc/pasture_config.yaml'

  package { 'pasture':
    ensure   => present,
    provider => 'gem',
    before   => File[$pasture_config_file],
  }
  $pasture_config_hash = {
    'port'              => $port,
    'default_character' => $default_character,
    'default_message'   => $default_message,
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
}
```

When I'm finished, I use the `puppet parser` tool to check my syntax.

    puppet parser validate pasture/manifests/init.pp

<div class = "lvm-task-number"><p>Task 6:</p></div>

I will connect to `pasture.puppet.vm` to trigger a Puppet run and test my changes.
I used a tool to create a new node with that name for this lesson, added that
system to the Learning VM's `/etc/hosts`, and handled the cert signing
process for me. Though this is a new system, it has the same name as the one
I was working on in the previous lesson, so the classification in my `site.pp`
manifest will still apply.

    ssh learning@pasture.puppet.vm

I trigger a Puppet agent run.

    sudo puppet agent -t

If the run throws any errors, I can go back and review my code. Remember that the
`puppet parser` tool can check for syntax errors, but it does not guarantee
that my Puppet code can be correctly compiled into a catalog and define the
state I intend.

Once the Puppet run has successfully completed, I disconnect to return to my
session on the Learning VM itself.

    exit

I'll use the `curl` command again to see that my changes to the defaults have
taken effect.

    curl 'pasture.puppet.vm/api/v1/cowsay?message=Hello!'

## Review

In this lesson, I introduced *variables* and *templates*. I reworked the
`pasture` module to replace hard-coded values in my resources and
configuration files with variables.

With variables set in my manifest, I saw how to use the hash syntax and
EPP template function to pass those variables into a template. Within an `.epp`
template, I covered the *parameter tag*, which is used at the beginning of
a template to specify which variables are available within the template, and
*expression-printing tags*, which are used to insert variable values into the
content of my templatized file.

I mentioned that variables are an important part of the concepts introduced
in the following lessons. In the next video, I'll show how to create
a *parameterized class*, which will allow me to set important variables
in my class as I declare it. Parameters allow me to customize how a class
is configured without editing code in the module where the class is defined.
