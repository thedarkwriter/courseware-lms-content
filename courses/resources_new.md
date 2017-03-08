<!--
This is the template for the self-paced courses.
Put your content in between the comments that mark
out the different sections.  Text should be written
in markdown.
-->
<link rel="stylesheet" href="/static/selfpaced/selfpaced.css" markdown="1">
<script src="https://try.puppet.com/js/selfpaced.js" markdown="1"></script>
<script defer="" src="https://code.jquery.com/jquery-1.11.2.js" markdown="1"></script>
<div id="lesson" markdown="1">
<div id="instructions" markdown="1">
<div class="instruction-header" markdown="1">
<i class="fa fa-graduation-cap" markdown="1"></i>
Lesson
</div>
<div class="instruction-content" markdown="1">
<!-- Primary Text of the lesson -->
<!-------------------------------->

# Resources

**Resources** are the fundamental building blocks of Puppet's declarative
modeling syntax. Learning about resources will help you understand how Puppet
represents and interacts with a system you want it to manage.

At the end of this course you will be able to:

- Understand how resources on the system are modeled in Puppet's Domain Specific
  Language (DSL).
- Use Puppet to inspect resources on your system.
- Use the Puppet Apply tool to make changes to resources on your system.
- Learn about the Resource Abstraction Layer (RAL).

## Resources

Puppet's foundation is a system called the *resource abstraction layer*.
Puppet interprets any aspect of your system configuration you want to manage
(users, files, services, and packages, to give some common examples) as a unit
called a *resource*. Puppet knows how to translate back and forth between the
resource syntax and the 'native' tools of the system it's running on. Ask
Puppet about a user, for example, and it can represent all the information
about that user as a resource of the *user* type. Of course, it's more useful
to work in the opposite direction. Describe how you want a user resource to
look, and Puppet can go out and make all the changes on the system to actually
create or modify a user to match that description.

The block of code that describes a resource is called a **resource
declaration**.  These resource declarations are written in Puppet code, a
Domain Specific Language (DSL) based on Ruby.

### Puppet's Domain Specific Language

A good understanding of the Puppet DSL is a key first step in learning how to
use Puppet effectively. While tools like the PE console give you quite a bit of
power to make configuration changes at a level above the code implementation,
it always helps to have a solid understanding of the Puppet code under the
hood.

Puppet's DSL is a *declarative* language rather than an *imperative* one. This
means that instead of defining a process or set of commands, Puppet code
describes (or declares) only the desired end state. With this desired state
described, Puppet relies on built-in *providers* to handle implementation.

One of the points where there is a nice carry over from Ruby is the *hash*
syntax. It provides a clean way to format this kind of declarative model, and
is the basis for the *resource declarations* you'll learn about in this quest.

As we mentioned above, a key feature of Puppet's declarative model is that it
goes both ways; that is, you can inspect the current state of any existing
resource in the same syntax you would use to declare a desired state.

The `puppet resource` tool lets you see how Puppet represents resources on
a system. The syntax of the command is: *puppet resource \<type\> \<name\>*.

The command `puppet resource user root`, will return something like the
following, though the exact details might vary depending on your operating
system and the details of the root user account.

<pre>
    user { 'root':
      ensure           => present,
      comment          => 'root',
      gid              => '0',
      home             => '/root',
      password         => '$1$jrm5tnjw$h8JJ9mCZLmJvIxvDLjw1M/',
      password_max_age => '99999',
      password_min_age => '0',
      shell            => '/bin/bash',
      uid              => '0',
    }
</pre>

This resource declaration syntax is composed of three main components:

- Type
- Title
- Attribute value pairs

We'll go over each of these below.

### Resource Type

You'll get used to the resource syntax as you use it, but for this first look
we'll go through the example point by point.

We'll start with the first line first:

<pre>
  user { 'root':
    ...
  }
</pre>

The word `user`, right _before_ the curly brace, is the **resource type**.
The type represents the kind of thing that the resource describes. It tells
Puppet how to interpret the rest of the resource declaration and what kind of
providers to use for managing the underlying system details.

Puppet includes a number of built-in resource types, which allow you to manage
aspects of a system. Below are some of the core resource types you'll encounter
most often:

* `user` A user
* `group` A user group
* `file` A specific file
* `package` A software package
* `service` A running service
* `cron` A scheduled cron job
* `exec` An external command
* `host` A host entry

If you are curious to learn about all of the built-in resources types
available, see the [Type Reference
Document](http://docs.puppetlabs.com/references/latest/type.html)
or try the command `puppet describe --list`.

### Resource Title

Take another look at the first line of the resource declaration.

<pre>
  user { 'root':
    ...
  }
</pre>

The single quoted word `'root'` just before the colon is the resource
**title**.  Puppet uses the resource title as its own internal unique
identifier for that resource. This means that no two resources of the same type
can have the same title.

In our example, the resource title, `'root'`, is also the name of the user
we're inspecting with the `puppet resource` command. Generally, a resource
title will match the name of the thing on the system that the resource is
managing. A package resource will usually be titled with the name of the
managed package, for example, and a file resource will be titled with the full
path of the file.

Keep in mind, however, that when you're creating your own resources, you can
set these values explicitly in the body of a resource declaration instead of
letting them default to the resource title. For example, as long as you
explicitly tell Puppet that a user resource's `name` is `'root'`, you can
actually give the resource any title you like. (`'superuser'`, maybe, or even
`'spaghetti'`) Unless you have a good reason to do otherwise, however, using
a title that will also provide a valid value for the namevar will make your
code more concise and readible.

### Attribute Value Pairs

Now that we've covered the *type* and *title*, take a look at the body of the
resource declaration.

<pre>
user { 'root':
  ensure           => present,
  comment          => 'root',
  gid              => '0',
  home             => '/root',
  password         => '$1$jrm5tnjw$h8JJ9mCZLmJvIxvDLjw1M/',
  password_max_age => '99999',
  password_min_age => '0',
  shell            => '/bin/bash',
  uid              => '0',
}
</pre>

After the colon in that first line comes a hash of **attributes** and their
corresponding **values**. Each line consists of an attribute name, a `=>`
(pronounced 'hash rocket'), a value, and a final comma. For instance, the
attribute value pair `home => '/root',` indicates that root's home is set to the
directory `/root`.

So to bring this all together, a resource declaration will match the following
pattern:

<pre>
type {'title':
    attribute => 'value',
}
</pre>

Note that the comma at the end of the final attribute value pair isn't required
by the parser, but it is best practice to include it for the sake of
consistency. Leave it out, and you may forget to insert it when you add another
attribute value pair on the following line!

<!-- End of primary test of the lesson --> </div>
<div class="instruction-header" markdown="1">
<i class="fa fa-desktop"></i>
Practice
</div>
<div class="instruction-content" markdown="1">
<!-- High level description of the exercise. -->
<!-------------------------------------------->
Now it's your turn to try it out. Using the sandbox environment we've provided
for this lesson, use the `puppet resource` tool to investigate some other
resource types.
<!-- End of high level description. -->
</div>
<div class="instruction-header" markdown="1">
<i class="fa fa-square-check-o"></i>
Instructions
</div>
<div class="instruction-content" markdown="1">
<!-- Step by step instructions -->
<!-------------------------------->

First, let's take a look at the `network` service. Before running any command,
take a moment to guess how Puppet might represent a service on the system. What
essential information would puppet need to know about the state of a service?

    puppet resource service network

To see what these parameters mean and find the full set of parameters and
values for the `service` resource type, either visit the [Resource Type
Reference](https://docs.puppet.com/puppet/latest/type.html) docs page or use
the `puppet describe` command.

    puppet describe service

What do you think would happen if you ran the `puppet resource service` command
without specifying a resource title? Go ahead and give it a try.

    puppet resource service

Puppet will show you the state of all the services it can find on your system.

Now that you know your way around a resource, pick another resource type and
use the `puppet resource` and `puppet describe` commands to explore that type.
(Note that if you pick the `file` resource type, `puppet resource file` will
result in an error message. Why do you think this is?)

<!-- End of step by step instruction -->
</div>

<div class="instruction-header" markdown="1">
</div>


</div>
<div id="terminal" markdown="1">
  <iframe name="terminal" src="https://try.puppet.com/sandbox/"></iframe>
</div>
</div>
