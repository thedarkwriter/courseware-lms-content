{% include '/version.md' %}

# Class parameters

## Getting started

In this lesson, I'll introduce class parameters. I'll show you the value of writing 
configurable classes and teach you the syntax for creating a *parameterized class.*
I'll also show how to use the *resource-like* class declaration syntax to set the
parameters for a class.

In the last video, I used variables to introduce some flexibility to the
`pasture` module. So far, however, all of the variables are assigned within the
class itself.

A well-written module in Puppet should let you customize all its 
important variables without editing the module itself. This is done with
*class parameters*. Writing parameters into a class allows you to declare
that class with a set of parameter-value pairs similar to the resource
declaration syntax. This gives you a way to customize all the important
variables in your class without making any changes to the module that defines
it. 

To get started, I'll enter the following command:

    quest begin class_parameters

## Writing a parameterized class

A class's parameters are defined as a comma-separated list of parameter name
and default value pairs (`$parameter_name = default_value,`). These parameter
value pairs are enclosed in parentheses (`(...)`) between the class name and
the opening curly bracket (`{`) that begins the body of the class. For
readability, multiple parameters should be listed one per line, for example:

```puppet
class class_name (
  $parameter_one = default_value_one,
  $parameter_two = default_value_two,
){
 ...
}
```

Notice that this list of parameters must be comma-separated, while variables
set within the body of the class itself are not. This is because the Puppet
parser treats these parameters as a list, while variable assignments in the
body of the class are individual statements. These parameters are available as
variables within the body of the class.

<div class = "lvm-task-number"><p>Task 1:</p></div>

To get started, I'll modify the main `pasture` class to use class parameters.
I'll open my `init.pp` manifest.

    vim pasture/manifests/init.pp

My parameter list will replace the variables assignments I used in the
previous lesson. By setting the parameter defaults to the same values I had
assigned to those variables, I can maintain the same default behavior for the
class.

I'll remove the variables set at the beginning of my class and add a corresponding
set of parameters. 

```puppet
class pasture (
  $port                = '80',
  $default_character   = 'sheep',
  $default_message     = '',
  $pasture_config_file = '/etc/pasture_config.yaml',
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

When I'm done making these changes, I save and exit my file.

## Resource-like class declarations

Now that my class has parameters, let's see how these parameters are set.

Until now, I've been using `include` to declare the class as part of my
node classification in the `site.pp` manifest. This `include` function declares
a class without explicitly setting any parameters, allowing any parameters in
the class to use their default values. Any parameters without defaults take the
special `undef` value.

To declare a class with specific parameters, use the *resource-like class
declaration*. As the name suggests, the syntax for a resource-like class
declaration is very similar to a resource declaration. It consists of the
keyword `class` followed by a set of curly braces (`{...}`) containing the
class name with a colon (`:`) and a list of parameters and values. Any values
left out in this declaration are set to the defaults defined within the class,
or `undef` if no default is set.

```puppet
class { 'class_name':
  parameter_one => value_one,
  parameter_two => value_two,
}
```

Unlike the `include` function, which can be used for the same class in multiple
places, resource-like class declarations can only be used once per class.
Because a class declared with the `include` uses defaults, it will always be
parsed into the same set of resources in my catalog. This means that Puppet
can safely handle multiple `include` calls for the same class. Because 
multiple resource-like class declarations are not guaranteed to lead to the same
set of resources, Puppet has no unambiguous way to handle multiple
resource-like declarations of the same class. Attempting to make multiple
resource-like declarations of the same class will cause the Puppet parser to
throw an error.

Though I won't go into detail here, know that external data-sources
like `facter` and `hiera` can provide lots of flexibility in your classes
even with the include syntax. For now, be aware that though the
`include` function uses defaults, there are ways to make those defaults very
intelligent.

<div class = "lvm-task-number"><p>Task 2:</p></div>

Now I'll go ahead and use a resource-like class declaration to customize the
`pasture` class from the `site.pp` manifest. Most of the defaults will still
work well, but for the sake of this example, let's set this instance of our
Pasture application to use the classic cow character instead of the sheep we
had set as the parameter default.

I'll open my `site.pp` manifest.

    vim /etc/puppetlabs/code/environments/production/manifests/site.pp

And modify my node definition for `pasture.puppet.vm` to include a
resource-like class declartion. I'll set the `default_character` parameter
to the string `'cow'`, and leave the other two parameters unset, letting them
take their default values.

```puppet
node 'pasture.puppet.vm' {
  class { 'pasture':
    default_character => 'cow',
  }
}
```

Notice that with my class parameters set up, all the necessary configuration
for all the components of the Pasture application can be handled with a single
resource-like class declaration. The diverse commands and file formats that
would ordinarily be involved in managing this application are reduced to this
single set of parameters and values.

<div class = "lvm-task-number"><p>Task 3:</p></div>

Now I'll connect to the `pasture.puppet.vm` node.

    ssh learning@pasture.puppet.vm

And trigger a Puppet agent run to apply this parameterized class.

    sudo puppet agent -t

When the run is complete, I'll return to the master.

    exit

And check that my configuration changes have taken effect.

    curl 'pasture.puppet.vm/api/v1/cowsay?message=Hello!'

## Review

In this lesson, I introduced *class parameters*, a way to customize a class
as it's declared. These parameters let me set up a single interface
to customize any aspect of the system my Puppet module manages.

I also revisited the `include` function and covered the *resource-like class
declaration*, the syntax for specifying values for a class's parameters as they
are declared.

In the next lesson, I'll introduce *facts*, which can be used to easily
introduce data about your agent system into your Puppet code.

