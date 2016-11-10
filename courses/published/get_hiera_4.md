<link rel="stylesheet" href="/static/selfpaced/selfpaced.css" markdown="1">
<script src="https://try.puppet.com/js/selfpaced.js" markdown="1"></script>

<div id="lesson" markdown="1">

<div id="instructions" markdown="1">

<div class="instruction-header">
<i class="fa fa-graduation-cap"></i>
Lesson
</div>

<div class="instruction-content" markdown="1">

So far, all of our Hiera data files have been in a single directory.
Depending on the complexity of your data, this might be fine,
but chances are you'll want to split things up.

For example, what if you have some configuration that only applies to
individual nodes? It isn't best practice, but sometimes you need to have a
couple of unique snowflakes in your infrastructure.

To support per-node configuration in Hiera, it's best to use the `certname`
trusted fact. By default this is the fully qualified domain name of the node 
when the certificate was generated and it's the unique name that the master 
knows the node by.  It's more secure than using the hostname fact since a 
compromised node could report a false hostname, but it can't fake another 
node's certificate.

In order to keep all those YAML files from cluttering up our `hieradata` folder,
we'll put them in a subfolder called `nodes`. By default, your `hiera.yaml` should
come with this level of the hierarchy already:

<pre>
---
:backends: "yaml"
:yaml:
  :hierarchy:
    - "nodes/%{::trusted.certname}"
    - "%{app_tier}"
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

This isn't limited to a single directory, you can have multiple subdirectories.
You can even use have more complex levels of the hierarchy. For example, if you
have multiple datacenters each with a `dev` and `prod` app tier, you could use 
a custom fact of `datacenter` to have something like this:
<pre>
---
:backends: "yaml"
:yaml:
  :hierarchy:
    - "nodes/%{::trusted.certname}"
    - "%{datacenter}/%{app_tier}"
    - "common"
</pre>

To test `trusted.certname` you'll need to use `puppet agent` and you'll obviously
only be able to test your actual trusted certname. Remember, you can't use
`trusted.certname` with puppet apply and you can't change the `hiera.yaml` hierarchy
on the master from your node.

To give a more complex configuration a try, use something like `hostname`
instead of `trusted.certname` in your node's hiera.yaml. Then you can use
the `hiera` command line tool, which lets use specify the values for various
facts by passing them as parameters.

For example, to find out the MOTD on the dev servers in the Portland 
datacenter, you would use this command:
<pre>
hiera message app_tier=dev datacenter=portland environment=production
</pre>

`environment` is specified here because the `hiera` command line tool
doesn't supply any default facts.

</div>

<div class="instruction-header">
<i class="fa fa-desktop"></i>
Practice
</div>

<div class="instruction-content" markdown="1">

We've set up a complex hierarchy in the production code environment on your
agent node, explore a bit, add some key/value pairs, and see if you can get a
sense of how Hiera behaves. What happens if you use a hostname that doesn't
have a corresponding YAML file? How about an app tier that doesn't exist?
What if you set up conflicting values?

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
