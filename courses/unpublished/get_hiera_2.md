<div id="lesson" markdown="1">

<div id="instructions" markdown="1">

<div class="instruction-header">
<i class="fa fa-graduation-cap"></i>
Lesson
</div>

<div class="instruction-content" markdown="1">

Hiera is pretty handy for keeping all of your data in one place, when you add a
level of hierarchy it becomes a lot more powerful.

Let's imagine you have two webservers, one is in your "production" environment
and one is in your "development" environment.  They are mostly the same, but
they need to use different DNS servers.

Without Hiera, your code might look like this:
<pre>
case $environment {
  'production': {
    $dns_server = 'proddns.puppetlabs.vm'
  }
  'development': {
    $dns_server = 'devdns.puppetlabs.vm'
  }
}
profile::dns_server {
  dns_server => $dns_server,
}
</pre>

This is simple enough for two servers. What if you add developer workstations
or another pre-production test environment? What if there are more
configuration differences between environments? The code can quickly get out of
control.

Let's look at how the code would appear in using Hiera:
<pre>
$dns_server = hiera('$dns_server')
profile::dns_server {
  dns_server => $dns_server,
}
</pre>

So what happened to the details? Now they're in two separate files, one for
each environment. They go in the same directory as `common.yaml`

Here's the production environment, we'll call it `production.yaml`
<pre>
---
dns_server: 'proddns.puppetlabs.vm'
</pre>

And here's the dev environment, we'll call it `development.yaml`
<pre>
---
dns_server: 'devdns.puppetlabs.vm'
</pre>

There's one place you need to change things, that's in your `hiera.yaml`.
You'll have to add another level to the hierarchy, above "common". Since we
want to use the value of the environment and not just the word "environment",
we'll need to add some special syntax.

Here's what the `hiera.yaml` needs to look like:
<pre>
---
:backends: "yaml"
:yaml:
  :datadir: "/etc/puppetlabs/code/hieradata"
  :hierarchy:
    - "%{environment}"
    - "common"
</pre>

</div>

<div class="instruction-header">
<i class="fa fa-desktop"></i>
Practice
</div>

<div class="instruction-content" markdown="1">

Before we go further, why not try out what you've just learned? To tell the
command line `hiera` tool what value to use for `environment` just add it after
the key.

For example, to check the `dns_server` in the `production` environment, you
would use this command:

<pre>
hiera dns_server environment=production
</pre>

</div>

<div class="instruction-header">
<i class="fa fa-square-check-o"></i>
Instructions
</div>

<div class="instruction-content" markdown="1">

Try adding another environment called "qa", or even another level in the
hierarchy that's based on the `hostname` fact instead of `environment`.

</div>

<a href="https://try.puppet.com/sandbox/?get_hiera2" class="btn btn-default" target="terminal">Start Practice Session</a>

</div>

<div id="terminal">
  <iframe name="terminal"></iframe>
</div>

</div>
