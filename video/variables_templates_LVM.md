{% include '/version.md' %}

# Variables and templates

## Getting started

In this lesson, I'll introduce variables and templates. I'll show you how to create an
EPP template, then use the hash syntax to populate the EPP template with variables defined
in a Puppet manifest.

While it's convenient to introduce variables and templates together,
variables are also used along with many of Puppet's other features to help write adaptable
Puppet code.

To give you a concrete example as I discuss these topics, I'll expand on the Pasture module
I began in the previous lesson. Adding variables and templates to make the module more
adaptable. Rather than having all my configuration options hard-coded into the module, I'll
begin defining the interface that will let these options be customized through Puppet.

To get started, I'll use the quest begin command to set up the environment for this
lesson:

    quest begin variables_and_templates

## Variables

Defining a variable in Puppet binds a value to a variable name. That variable
name can then be used anywhere in your manifest to refer back to the assigned value.

In the Puppet language, a variable name is prefixed with a `$` (dollar sign),
and a value is assigned with the `=` operator. Assigning a short string to a variable,
for example, looks like this:

```puppet
$my_variable = 'look, a string!'
```

Once I have defined a variable, I can use it anywhere in my manifest where
I want to use the assigned value. Note, however, that unlike resources, variables are parse-order
dependent, which means that a variable has to be defined in your above the place
where it's used.
Also note that trying to use an undefined variable won't always lead to an error.
An undefined variable has a special `undef` value, which may or may not cause
compilation errors or unexpected behaviours depending on how it's used later in a manifest.

Despite the name, Puppet variables are technically *constants* from the perspective of
the Puppet parser as it parses Puppet code to create a catalog. This means that once a
variable is assigned, the value is fixed and cannot be changed later in the manifest. Here, the
*variability* refers to the fact that a variable can have a different
value set across different Puppet runs or across different nodes, not that it can change
within the same manifest.

<div class = "lvm-task-number"><p>Task 1:</p></div>

I'll adapting the pasture module by setting up a few variables. I'll use variables
to define the default haracter the cowsay application will use, the port we want to service to
run on, and path of the configuration file.

First I'll open the `init.pp` manifest.

    vim pasture/manifests/init.pp

I'll assign these variables at the top of the class, then replace the hard-coded
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
variables. These are actually configuration options defined in Pasture's config
file, so to use these, I need a way to get them into that file. I'll also need
to pass the `$pasture_config_file` variable to my service unit file so I can ensure
that the service always knows where to find the right config file to load.

To do this, I'll need to use templates.

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
different part of the file, there are a few ways to do this, such as Augeas,
concat, or the file_line resource type. I won't be addressing these tools directly
in these lessons, but I've included links below this in case you want to learn
more.

## Embedded Puppet templating language

Puppet supports two templating languages, Embedded Puppet
(or EPP) and Embedded Ruby (or ERB).

EPP templates were released in Puppet 4 to provide a Puppet-native templating
language a little better suited to Puppet than the ERB templating format that had
been inherited from the Ruby and used before. Because EPP is now the preferred method,
it's what I'll be using in this lesson. Once you understand the basics of
templating, however, you can easily use the ERB format by referring to the
documentation.

<div class = "lvm-task-number"><p>Task 2:</p></div>

It will be easier to explain the syntax with a concrete example. I'll begin
by creating a template to help manage Pasture's configuration file.

First, I'll need to create a `templates` directory in my `pasture` module.

    mkdir pasture/templates

Next, I'll create a `pasture_config.yaml.epp` template file.

    vim pasture/templates/pasture_config.yaml.epp

Best practice is to begin an EPP template with a *parameter tag*. This
declares which parameters the template will accept. While a template will
work without this tag, explicitly declaring the variables here makes the
template readable and easier to maintain if I come back to it later.

```
<%- | $port,
      $default_character,
      $default_message,
| -%>
```

The pipes (`|`) surrounding 
the list of parameters are a special syntax that
define the parameters tag. The opening and closing angle-bracket percent symbols are
the opening and closing tag delimiters that distinguish EPP tags from the body of the file.
Those hyphens (`-`) next to the tag delimiters tell the EPP parser to remove indentation and whitespace
before and after the tag. This lets me put this parameter tag at the
beginning of the file, for example, without the newline character after the
tag creating an empty line at the beginning of the output file.

It's also good practice to add a comment to the beginning of the file so
people who come across it know that it's managed by Puppet, and than any manual
changes they make will be reverted the next time Puppet runs. 

```
<%- | $port,
      $default_character,
      $default_message,
| -%>
# This file is managed by Puppet. Please do not make manual changes.
```

This comment is intended to be included directly in the final file, so I need to use the
comment syntax native to the target file format, in this case, YAML.

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

Using the equals sign just after the opening tag delimiter makes an
*expression-printing tag*. These tags insert the content of a Puppet
expression, into the file. In this case, I'm inserting the string values
assigned to my variables.

Now that this template is set up, I'll return to my `init.pp` manifest
and see how to use it to define the content of a `file` resource.

First, I'll save my template file and exit Vim.

<div class = "lvm-task-number"><p>Task 3:</p></div>

Now I'll open my `init.pp` manifest.

    vim pasture/manifests/init.pp

The `file` resource type has two different parameters that can be used to
define the content of the managed file: `source` and `content`.

As you saw in the last lesson the, `source` parameter takes the URI of a
source file and sets the target file's content to that of the source file.
The `content` parameter takes a string as a value and uses that string
directly to define the target file's content.

To set a file's content with a template, I'll use Puppet's built-in `epp()`
function. This function parses an EPP template file and returns the resulting
string, which I can then use to set the value of a file resource's `content` parameter.

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

Now I'll return to my `init.pp` manifest and modify the file
resource for my service unit file to use the template I
just created.

    vim pasture/manifests/init.pp

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

Now that this is done, I'll use the `puppet parser` tool to check my syntax.

    puppet parser validate pasture/manifests/init.pp

<div class = "lvm-task-number"><p>Task 6:</p></div>

To test my changes, I'll connect to `pasture.puppet.vm` and trigger a Puppet.
Though the quest tool created a new node for this lesson, it has the same name as the one
I was working on in the previous lesson, so the classification in my `site.pp`
manifest will still apply.

    ssh learning@pasture.puppet.vm

    sudo puppet agent -t

Now that the run is complete, I'll disconnect.

    exit

and run the `curl` against the cowsay api to see my new changes in effect.

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
