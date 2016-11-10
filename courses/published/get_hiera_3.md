<link rel="stylesheet" href="/static/selfpaced/selfpaced.css" markdown="1">
<script src="https://try.puppet.com/js/selfpaced.js" markdown="1"></script>

<div id="lesson" markdown="1">

<div id="instructions" markdown="1">

<div class="instruction-header">
<i class="fa fa-graduation-cap"></i>
Lesson
</div>

<div class="instruction-content" markdown="1">

In the last lesson, we assigned the value of a variable using the `hiera()`
function and that variable was passed into a profile called `profile::dns`.
There is actually a better pattern for doing this, you can use the `hiera()`
function inside the class definition as the default parameter.

So when you define your `profile::dns` class it would look something like this:
<pre>
class profile::dns (
  $dns_server = hiera('dns_server')
) {
...
}  
</pre>

Since you wouldn't need to specify the `dns_server` parameter when you declare
the class, you can now include the `profile::dns` class with this code:
<pre>
include profile::dns
</pre>

This is a very common convention and was recommended best practice. You'll
will often see it in older forge modules or code written by developers who
have used puppet since before version 3. 

There's a problem with using hiera this way; As you write more code like this, 
it becomes very easy to lose track of which key/value pair applies to what class. 
The standard convention is to use the name of class as part of the Hiera key 
like this:
`profile::dns::dns_server`.

This convention isn't just to make things easy to remember. Since Puppet 3,
there has been a feature called "Automatic Parameter Lookup" which means you
can leave out the Hiera call from the class definition. When the Puppet master
compiles a catalog for your node it will check in Hiera before falling back to
the defaults.

In our example, let's assume there's a default value in `profile::params`:

<pre>
class profile::dns (
  $dns_server = $profile::params::dns_server
) {
...
}
</pre>

Now if there is a value in Hiera for `profile::dns::dns_server` the master will
use that, otherwise it will fall back to what's in `params.pp` of the "profile"
module. You may be thinking that Hiera understands namespaces, so it's somehow
filing the `dns_server` key under `profile::dns`, but that isn't correct. Hiera
just uses the entire string `profile::dns::dns_server` as a single key.

As always, you can override both defaults by specifying the
parameter yourself, like this:

<pre>
class {'profile::dns':
  dns_server => 'globaldns.puppetlabs.vm',
}
</pre>

The order of precedence is to check for class declaration parameters, then
hiera, then class defaults.

</div>

<div class="instruction-header">
<i class="fa fa-desktop"></i>
Practice
</div>

<div class="instruction-content" markdown="1">

Automatic Parameter Lookup is one of the ways in which Hiera can seem "magical"
to new users.  To help you get the hang of how it works, we've created a few
example classes that take parameters. Play around with it until it makes sense.

For this exercise, you'll be running `puppet agent -t` against a Puppet master.
For convenience, we've made a link to your agent's environment on the master to
the `/root/puppetcode` directory on the agent node.  You can just declare the
example classes in the `default` node definition in
`/root/puppetcode/manifests/site.pp` and run puppet on your agent node.

Hiera lookups are done on the master, so you'll need to change the files in 
`/root/puppetcode/hieradata` which is mapped to your code environment.

The master doesn't use the `hiera.yaml` on your agent so you won't be able to
change the hierarchy, but the default configuration is to include the 
`hieradata` directory in your code environment.
</div>

<div class="instruction-header">
<i class="fa fa-pencil"></i>
</div>

<div class="instruction-content" markdown="1">

When you run `puppet agent -t` you will see a notice that about your code
environment. This is because the agent defaults to `production` but the master
enforces another code environment we have automatically set up.

Remember, if you break something, just reload the page and you'll get a fresh
node and code environment.
</div>


</div>

<div id="terminal">
  <iframe src="https://try.puppet.com/sandbox/?course=get_hiera3" name="terminal"></iframe>
</div>

</div>
