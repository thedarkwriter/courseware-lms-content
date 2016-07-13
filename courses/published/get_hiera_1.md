<link rel="stylesheet" href="/static/selfpaced/selfpaced.css" markdown="1">

<div id="lesson" markdown="1">

<div id="instructions" markdown="1">

<div class="instruction-header" markdown="1">
<i class="fa fa-graduation-cap" markdown="1"></i>
Lesson
</div>

<div class="instruction-content" markdown="1">
When you first start using Puppet, you might include configuration details in
your Puppet code.  For example, when setting up a database server, you might
hard-code the hostname of the server in the Puppet manifest. As your puppet
implementation grows, this can become unmanageable. Making a small change to an
system might mean making changes across multiple parts of your Puppet code.
Hiera offers a robust and straightforward way to separate data from code.

The name 'Hiera' stands for hierarchy, but the most basic functional Hiera
config doesn't have to be hierachical.  Let's set up a simple flat lookup using
Hiera.  

Imagine you want to set a default message of the day on your servers.  You
could do this with the following Puppet code:

<pre>
$message = "Welcome to $::hostname. Don't break anything!"
file { '/etc/motd':
  content => $message
}
</pre>

This works just fine, but the more you hard-code data into your Puppet code,
the harder it is to maintain.  What if you wanted to share that code with
someone outside your company? You'd have to remember to go in and clean out any
potentially sensitive data across your entire codebase.

Even with the simplest configuration Hiera offers a robust way to separate that
data from your code.

Using Hiera, the code would look this this:
<pre>
$message = hiera("message")
file { '/etc/motd':
  content => $message
}
</pre>

You'll need to tell Hiera where to find the data, you can do this by creating a
file called `/etc/puppetlabs/code/hiera.yaml`:

<pre>
---
:backends: "yaml"
:yaml:
  :datadir: "/etc/puppetlabs/code/hieradata/"
  :hierarchy:
    - "common"
</pre>

Since this is a simple example, our hierarchy only has one level, "common". In
future lessons, we'll add some more levels. We'll keep "common" as the base of
the hierarchy as a place to hold global defaults. 

We still need to add the actual data. Do this by creating a file called
`common.yaml` in the `datadir` that's listed in `hiera.yaml`

`common.yaml` looks like this:
<pre>
---
message: "Welcome to $::hostname. Don't break anything!"
</pre>

</div>

<div class="instruction-header" markdown="1">
<i class="fa fa-desktop"></i>
Practice
</div>

<div class="instruction-content" markdown="1">

Now that you have a sense of the basic config, try adding another key/value
pair to the `common.yaml` on the practice VM. Experiment with changing things
to see what results you get. Don't worry if you break something, just reload
the page to get a fresh machine.

</div>

<div class="instruction-header" markdown="1">
<i class="fa fa-square-check-o"></i>
Instructions
</div>

<div class="instruction-content" markdown="1">

To test out Hiera, you can use the `hiera` command line tool.  For example, to
lookup the value of "message", type `hiera message`.

Add a second key by editing `/etc/puppetlabs/code/hieradata/common.yaml`

</div>

<div class="instruction-header" markdown="1">
<i class="fa fa-pencil"></i>
Notes
</div>

<div class="instruction-content" markdown="1">

When you're ready to move on, just click to the next section, the practice
machine will shut down automatically when you're done.

If you need a refresher in the Linux command line or in using the vim text
editor, take a look at those courses before proceeding.

</div>

<a href="https://try.puppet.com/sandbox/?course=get_hiera1" class="btn btn-default" target=    "terminal">Start Practice Session</a>

</div>

<div id="terminal" markdown="1">
  <iframe name="terminal"></iframe>
</div>

</div>
