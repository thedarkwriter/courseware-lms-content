<link rel="stylesheet" href="/static/selfpaced/selfpaced.css" markdown="1">
<div id="lesson" markdown="1">

<div id="instructions" markdown="1">

<div class="instruction-header">
<i class="fa fa-graduation-cap"></i>
Lesson
</div>

<div class="instruction-content" markdown="1">

Before we move on to other ways of using Hiera data, let's take a look at few
of the configuration options in `hiera.yaml` So far, all of our Hiera data
files have been in a single directory. Depending on the complexity of your
data, this might be fine, but chances are you'll want to split things up.

For example, what if you have some configuration that only applies to
individual nodes? It isn't best practice, but sometimes you need to have a
couple of unique snowflakes in your infrastructure.

To support per-node configuration in Hiera, it's best to use the `clientcert`
fact.  By default this is the hostname of the node when the certificate was
generated and it's the unique name that the master knows the node by.  It's
more secure than using the hostname fact since a compromised node could report 
a false hostname, but it can't fake another node's certificate.

In order to keep all those YAML files from cluttering up our `hieradata` folder,
we'll put them in a subfolder called `nodes` and add that level to the top of
our hierarchy in `hiera.yaml`:

<pre>
---
:backends: "yaml"
:yaml:
  :datadir: "/etc/puppetlabs/code/hieradata"
  :hierarchy:
    - "nodes/%{clientcert}"
    - "%{environment}"
    - "common"
</pre>

Let's go back to the message of the day example to try this one out. Imagine
you've got two developers, Jane and Bob. They each have a development server
for testing out their code.

Jane wants to see some useful information when she logs in, so
`nodes/jane.puppetlabs.vm.yaml` looks like this:
<pre>
---
message: "Welcome to ${hostname}. ${osfamily} - ${memorysize}"
</pre>

Bob is more territorial, so `nodes/bob.puppetlabs.vm.yaml` looks like this:
<pre>
---
message: "This is Bob's development server. Don't touch anything, or else!"
</pre>

Since you can't log in to the actual machines, you can test out Hiera's
response to different hostnames by passing in `clientcert` as a variable to the
`hiera` command line tool:
<pre>
hiera message clientcert=jane.puppetlabs.vm
</pre>

This isn't limited to a single directory, you can have multiple subdirectories.
You can even use have more complex levels of the hierarchy. For example, if you
have multiple datacenters each with a `development` and `production` environment,
you could use a custom fact of `datacenter` to have something like this:
<pre>
---
:backends: "yaml"
:yaml:
  :datadir: "/etc/puppetlabs/code/hieradata"
  :hierarchy:
    - "nodes/%{clientcert}"
    - "%{datacenter}/%{environment}"
    - "common"
</pre>

To give a more complex configuration a try you can pass multiple parameters to
the `hiera` command line tool.  For example, to find out the MOTD on the
development servers in the Portland datacenter, you would use this 
command:
<pre>
hiera message environment=development datacenter=portland
</pre>

</div>

<div class="instruction-header">
<i class="fa fa-desktop"></i>
Practice
</div>

<div class="instruction-content" markdown="1">

We've set up a complex hierarchy, explore a bit, add some key/value pairs, and
see if you can get a sense of how Hiera behaves. What happens if you use a
hostname that doesn't have a corresponding YAML file? How about an environment
that doesn't exist? What if you set up conflicting values? 

If this is starting to seem overwhelming, don't worry. Hierarchies of more than
a few levels are unusual in practice, so don't add complexity if you don't need
it. Even this example is probably more complex than most users will ever
need.

</div>


</div>

<div id="terminal">
  <iframe src="https://try.puppet.com/sandbox/?course=get_hiera4" name="terminal"></iframe>
</div>

</div>
