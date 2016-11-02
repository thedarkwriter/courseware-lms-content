<link rel="stylesheet" href="/static/selfpaced/selfpaced.css" markdown="1">
<div id="lesson" markdown="1">

<div id="instructions" markdown="1">

<div class="instruction-header">
<i class="fa fa-graduation-cap"></i>
Lesson
</div>

<div class="instruction-content" markdown="1">

Hiera is pretty handy for keeping all of your data in one place, when you add a
level of hierarchy it becomes a lot more powerful.

Let's imagine you have two webservers, one is in your "prod" app tier and one 
is in your "dev" app tier.  They are mostly the same, but they need to use 
different DNS servers.

*Note: In puppet, the word `environment` refers to a set of puppet code that
applies to a certain set of nodes.  We use the term `app tier` to refer to a
physical set of nodes. This distinction isn't important for this course but it
becomes important when using recommended best practices for managing puppet code.*

Without Hiera, your code might look like this:
<pre>
case $::app_tier {
  'prod': {
    $dns_server = 'proddns.puppetlabs.vm'
  }
  'dev': {
    $dns_server = 'devdns.puppetlabs.vm'
  }
}
profile::dns_server {
  dns_server => $dns_server,
}
</pre>

This is simple enough for two servers. What if you add developer workstations
or another pre-production test app tier? What if there are more configuration
differences between app tiers? The code can quickly get out of
control.

Let's look at how the code would appear in using Hiera:
<pre>
$dns_server = hiera('$dns_server')
profile::dns_server {
  dns_server => $dns_server,
}
</pre>

So what happened to the details? Now they're in two separate files, one for
each app tier. They go in the same directory as `common.yaml`

Here's the prod tier datasource, we'll call it `prod.yaml`
<pre>
---
dns_server: 'proddns.puppetlabs.vm'
</pre>

And here's the dev tier datasource, we'll call it `dev.yaml`
<pre>
---
dns_server: 'devdns.puppetlabs.vm'
</pre>

There's one place you need to change things, that's in your `hiera.yaml`.
You'll have to add another level to the hierarchy, above "common". Since we
want to use the value of the app tier fact and not just the word "app_tier",
we'll need to add some special syntax.

Here's what the `hiera.yaml` needs to look like:
<pre>
---
:backends:
  - yaml
:hierarchy:
  - "nodes/%{::trusted.certname}"
  - "%{::app_tier}"
  - common

:yaml:
# datadir is empty here, so hiera uses its defaults:
# - /etc/puppetlabs/code/environments/%{environment}/hieradata on *nix
# - %CommonAppData%\PuppetLabs\code\environments\%{environment}\hieradata on Windows
# When specifying a datadir, make sure the directory exists.
  :datadir:
</pre>

Don't worry if you're confused by the syntax at this point, we'll talk about
it more later on. Note the other places in the file where the same syntax
is used.

</div>

<div class="instruction-header">
<i class="fa fa-desktop"></i>
Practice
</div>

<div class="instruction-content" markdown="1">

Before we go further, why not try out what you've just learned? 

You will need to set the `app_tier` fact. To do this create an external
fact called app_tier, by creating a file in `/opt/puppetlabs/facter/facts.d/my_facts.txt`
with the following contents
<pre>
app_tier=prod
</pre>

This time, try this one-liner puppet apply command to get the value of dns_server.
`puppet apply -e 'notify{hiera("dns_server"):}'`

Test out a few different app tiers by changing the value of your external fact.

You cal always check the value of that fact by running
<pre>
facter app_tier
</pre>

</div>

<div class="instruction-header">
<i class="fa fa-square-check-o"></i>
Instructions
</div>

<div class="instruction-content" markdown="1">

Try adding another app tier called `qa`, or even another level in the
hierarchy that's based on the `hostname` fact instead of `app_tier`.

Remember, `hostname` is a built in fact to find your hostname run
`facter hostname`.

</div>

</div>

<div id="terminal">
  <iframe src="https://try.puppet.com/sandbox/?course=get_hiera2" name="terminal"></iframe>
</div>

</div>
