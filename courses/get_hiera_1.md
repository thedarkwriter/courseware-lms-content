<link rel="stylesheet" href="/static/selfpaced/selfpaced.css" markdown="1">
<script defer="" src="//code.jquery.com/jquery-1.11.2.js" markdown="1"></script>
<script defer="" src="https://try.puppet.com/js/selfpaced.js" markdown="1"></script>

<div id="lesson" markdown="1">

<div id="instructions" markdown="1">

<div class="instruction-header" markdown="1">
<i class="fa fa-graduation-cap" markdown="1"></i>
Lesson
</div>

<div class="instruction-content" markdown="1">
When you first start using Puppet, you might include configuration details in
your Puppet code.  For example, when setting up a database server, you might
hard-code the hostname of the server in the Puppet manifest. As your Puppet
implementation grows, this can become unmanageable. Making a small change to a
system might mean making changes across multiple parts of your Puppet code.
Hiera offers a robust and straightforward way to separate data from code.

The name 'Hiera' stands for hierarchy, but the most basic functional Hiera
config doesn't have to be hierarchical.  Let's set up a simple flat lookup using
Hiera.  

Imagine you want to set a default message of the day on your servers.  You
could do this with the following Puppet code:

<pre>
$message = "Welcome to try.puppet.com. Don't break anything!"
file { '/etc/motd':
  content => $message
}
</pre>

This works just fine, but the more you hard-code data into your Puppet code,
the harder it is to maintain.  What if you wanted to share that code with
someone outside your company? You'd have to remember to go in and clean out any
potentially sensitive data across your entire codebase.

Even with the simplest configuration, Hiera offers a robust way to separate that
data from your code.

Using Hiera, the code would look this this:
<pre>
$message = hiera('message')
file { '/etc/motd':
  content => $message
}
</pre>

You'll need to tell Hiera where to find the data, this is done with the
`/etc/puppetlabs/puppet/hiera.yaml` file.  The file Puppet installs by default
will work:

<pre>
---
:backends:
  - yaml
:hierarchy:
  - "nodes/%{::trusted.certname}"
  - common
:yaml:
# datadir is empty here, so hiera uses its defaults:
# - /etc/puppetlabs/code/environments/%{environment}/hieradata on *nix
# - %CommonAppData%\PuppetLabs\code\environments\%{environment}\hieradata on Windows
# When specifying a datadir, make sure the directory exists.
  :datadir:
</pre>

The lines starting with `#` are comments, and for now just ignore the first item
under `:hierarchy:`, we're going to start with `common`. In future lessons, 
we'll add some more levels and use the defaults more. We'll keep "common" as 
the base of the hierarchy as a place to hold global defaults. 

Notice in the comment about default `datadir` that it says your data will be in
`/etc/puppetlabs/code/environments/%{environment}/hieradata`.
`%{environment}` part will be interpolated by Puppet to refer to your code
environment.  The default is `production`, so that's what we'll use for this
exercise.

We still need to add the actual data. Do this by creating a file called
`common.yaml` in the `datadir` that's listed in `hiera.yaml`

`common.yaml` looks like this:
<pre>
---
message: "Welcome to %{fqdn} Don't break anything!"
</pre>

Just like we use `%{environment}` the `%{fqdn}` will be interpolated as the
fully qualified domain name of your node.

</div>

<div class="instruction-header" markdown="1">
<i class="fa fa-desktop"></i>
Practice
</div>

<div class="instruction-content" markdown="1">

Now that you have a sense of the basic config, try adding another key/value
pair to the `common.yaml` on your agent node. Experiment with changing things
to see what results you get. Don't worry if you break something, just reload
the page to get a fresh machine.

</div>

<div class="instruction-header" markdown="1">
<i class="fa fa-square-check-o"></i>
Instructions
</div>

<div class="instruction-content" markdown="1">
If you haven't already, run `puppet agent -t` to set up your node with
example code.

**Note: You will see a notice about your code environment not matching the server. 
This is because nodes ask for "production" by default, but we've set up a
code environment just for your node.**

To test out Hiera, you can use make a simple manifest like the examples above
and use `puppet apply`. The notify resource can be handy for this.  For example, 
to lookup the value of "message", create a file `/root/message.pp`:

<pre>
notify{hiera('message'):}
</pre>

To see the hiera value run `puppet apply /root/message.pp`

Add a second key by editing `/etc/puppetlabs/code/environments/production/hieradata/common.yaml`

You node has `vim` already installed and you can install others such as `nano`
by using the command `puppet apply -e "package{'nano': ensure => present}"`
</div>

<div class="instruction-header" markdown="1">
<i class="fa fa-pencil"></i>
Notes
</div>

<div class="instruction-content" markdown="1">

Hiera data should live on the Puppet master. For learning how hiera works, 
we're editing code on the agent and using `puppet apply`.

If you make a mistake and would like a fresh practice environment, type
`exit` and click the `start session` button when it appears.

We've provided the courses Introduction to the Linux Command Line and 
An Introduction to Vim in case you need a refresher.

</div>


</div>

<div id="terminal" markdown="1">
  <iframe id="try" src="https://try.puppet.com/sandbox/?course=get_hiera1" name="terminal"></iframe>
</div>

</div>
