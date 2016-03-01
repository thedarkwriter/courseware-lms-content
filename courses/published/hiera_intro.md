# Getting started with Hiera - Part 1

When you first start using puppet, you might include configuration details in your puppet code.  For example, when setting up a database server, you might hard-code the hostname of the server in the puppet manifest. As your puppet implementation grows, this can become unmanageable. Making a small change to an system might mean making changes across multiple parts of your puppet code.  Hiera offers a robust and straightforward way to separate data from code.

The name 'hiera' stands for hierarcy, but the most basic functional hiera config isn't hierachical.  Let's set up a simple flat lookup using hiera.  

Imagine you want to set a default message of the day on your servers.  You could do this with the following puppet code:

<pre>
$message = "Welcome to $::hostname. Don't break anything!"
file { '/etc/motd':
  content => $message
}
</pre>

This works just fine, but the more you hard-code data into your puppet code, the harder it is to maintain.  What if you wanted to share that code with someone outside your company? You'd have to remember to go in and clean out any potentially sensitive data across your entire codebase.

Even with the simplest configuration hiera offers a robust way to separate that data from your code.

Using hiera, the code would look this this:
<pre>
$message = hiera("message")
file { '/etc/motd':
  content => $message
}
</pre>

You'll need to tell hiera where to find the data, you can do this by creating a file called `/etc/puppetlabs/code/hiera.yaml`:

<pre>
---
:backends: "yaml"
:yaml:
  :datadir: "/etc/puppetlabs/code/hieradata/"
  :hierarchy:
    - "common"
</pre>

Since this is a simple example, our hierarchy only has one level, "common". In future lessons, we'll add some more levels. We'll keep "common" as the base of the hierarchy as a place to hold global defaults. 

We still need to add the actual data. Do this by creating a file called `common.yaml` in the `datadir` that's listed in `hiera.yaml`

`common.yaml` looks like this:
<pre>
---
message: "Welcome to $::hostname. Don't break anything!"
</pre>

Now that you have a sense of the basic config, try adding another key/value pair to the `common.yaml` on the practice VM. Experiment with changing things to see what results you get. Don't worry if you break something, just reload the page to get a fresh machine.

To test out hiera, you can use the hiera command line tool.  For example, to lookup the value of "message", type `hiera message`.

When you're ready to move on, just click to the next section, the practice machine will shut down automatically when you're done.

If you need a refresher in the Linux command line or in using the vim text editor, take a look at those courses before proceeding.

## Exercise 1

Add a second key.


## Getting started with Hiera - Part 2

Hiera is pretty handy for keeping all of your data in one place, when you add a level of hierarchy it becomes a lot more powerful.

Let's imagine you have two webservers, one is in your "production" environment and one is in your "development" environment.  They are mostly the same, but they need to use differnt DNS servers.

Without hiera, your code might look like this:
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

This is simple enough for two servers. What if you add developer workstations or another pre-production test environment? What if there are more configuration differences between environments? The code can quickly get out of control.

Let's look at how the code would appear in using hiera:
<pre>
$dns_server = hiera('$dns_server')
profile::dns_server {
  dns_server => $dns_server,
}
</pre>

So what happened to the details? Now they're in two separate files, one for each environment. They go in the same directory as `common.yaml`

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

There's one place you need to change things, that's in your `hiera.yaml`.  You'll have to add another level to the hierarchy, above "common". Since we want to use the value of the environment and not just the word "environment", we'll need to add some special syntax.

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

Before we go further, why not try out what you've just learned? To tell the command line `hiera` tool what value to use for `environment` just add it after the key.

For example, to check the `dns_server` in the `production` environment, you would use this command:

<pre>
hiera dns_server environment=production
</pre>

Try adding another environment called "qa", or even another level in the hierarchy that's based on the `hostname` fact instead of `environment`.

## Exercise 2

Per environment hiera

## Getting started with Hiera - Part 3

In the last lesson, we assigned the value of a variable using the `hiera()` function and that variable was passed into a profile called `profile::dns`.  There is actually a better pattern for doing this, you can use the hiera function inside the class definition as the default parameter.

So when you define your `profile::dns` class it would look something like this:
<pre>
class profile::dns (
  $dns_server = hiera('dns_server')
) {
...
}  
</pre>

Since you wouldn't need to specify the `dns_server` parameter when you declare the class, you can now include the `profile::dns` class with this code:
<pre>
include profile::dns
</pre>

But there's a problem. As you write more code like this, it becomes very easy to lose track of which key/value pair applies to what class. The standard convention is to use the name of class as part of the hiera key like this: `profile::dns::dns_server`.

This convention isn't just to make things easy to remember. Since Puppet 3, there has been a feature called "Automatic Parameter Lookup" which means you can leave out the hiera call from the class definition. When the Puppet Master compiles a catalog for your node it will check in hiera before falling back to the defaults.

In our example, let's assume there's a default value in profile::params:

<pre>
class profile::dns (
  $dns_server = $profile::params::dns_server
) {
...
}
</pre>

Now if there is a value in hiera for `profile::dns::dns_server` the master will use that, otherwise it will fall back to what's in `params.pp` of the "profile" module.  As always, you can still override both defaults by specifying the parameter yourself:

<pre>
class {'profile::dns':
  dns_server => 'globaldns.puppetlabs.vm',
}
</pre>

Automatic Parameter Lookup is one of the ways in which hiera can seem "magical" to new users.  To help you get the hang of how it works, we've created a few example classes that take parameters. Play around with it until it makes sense.

For this exercise, you'll be running `puppet agent -t` against a Puppet Master.  For convenience, we've made a link to your agent's environment on the master to the `/root/puppetcode` directory on the agent node.  You can just declare the example classes in the `default` node definition in `/root/puppetcode/manifests/site.pp` and run puppet on your agent node.

Remember, if you break something, just reload the page and you'll get a fresh environment.

## Exercise 3

Automatic Parameter Lookup
Pre-loaded example code


## Getting started with Hiera - Part 4

Before we move on to other ways of using hiera data, let's take a look at few of the configuration options in `hiera.yaml`
So far, all of our hiera data files have been in a single directory. Depending on the complexity of your data, this might be fine, but chances are you'll want to split things up.

For example, what if you have some configuration that only applies to individual nodes? It isn't best practice, but sometimes you need to have a couple of unique snowflakes in your infrastructure.

To support per-node configuration in hiera, it's best to use the `clientcert` fact.  By default this is the hostname of the node when the certificate was generated and it's the unique name that the master knows the node by.  It's more secure than using the hostname since a compromised node could report a false hostname but can't fake another node's certificate.

In order to keep all those yaml files from cluttering up our hieradata folder, we'll put them in a subfolder called "nodes" and add that level to the top of our hierarchy in hiera.yaml:

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

Let's go back to the message of the day example to try this one out. Imagine you've got two developers, Jane and Bob. They each have a development server for testing out their code.

Jane wants to see some useful information when she logs in, so `nodes/jane.puppetlabs.vm.yaml` looks like this:
<pre>
---
message: "Welcome to ${hostname}. ${osfamily} - ${memorysize}"
</pre>

Bob is a little more territorial, so `nodes/bob.puppetlabs.vm.yaml` looks like this:
<pre>
---
message: "This is Bob's development server. Don't touch anything, or else!"
</pre>

This isn't limited to a single directory, you can have multiple subdirectories. You can even use have more complex levels of the hierarchy. For example, if you have multiple datacenters each with a development and production environment, you could use a custom fact of "datacenter" to have something like this:
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

If this is starting to seem overwhelming, don't worry. Hierachies of more than a few levels are unusual in practice, so don't add complexity if you don't need it.


# An Introduction to Hiera
Hiera is a key/value lookup tool for configuration data, built to make Puppet better and let you set node-specific data without repeating yourself. Hiera support is built into Puppet 3, and is available as an add-on for Puppet 2.7.

At the end of this course you will be able to: 

*   Describe the benefits of data separation with Hiera.
*   Explain a use case of Hiera and its basic configuration syntax.

## Video
[Link to Video](http://linktovideo)

## Transcript

## Slide 0



## Slide 1

Hiera is a key/value lookup tool for configuration data, built to make Puppet better and let you set node-specific data without repeating yourself.

## Slide 2

Hiera makes Puppet better by keeping site-specific data out of your manifests. Puppet classes can request whatever data they need, and your Hiera data will act like a site-wide config file.

## Slide 3

This makes it:
    Easier to configure your own nodes: default data with multiple levels of overrides is finally easy.
    Easier to re-use public Puppet modules: don’t edit the code, just put the necessary data in Hiera.
    Easier to publish your own modules for collaboration: no need to worry about cleaning out your data before showing it around, and no more clashing variable names.

## Slide 4

With Hiera, you can:
    Write common data for most nodes
    Override some values for machines located at a particular facility…
    …and override some of those values for one or two unique nodes.
This way, you only have to write down the differences between nodes. When each node asks for a piece of data, it will get the specific value it needs.

## Slide 5

To get started with Hiera, you’ll need to do the following:
    Install Hiera, if it isn’t already installed.
    Make a hiera.yaml config file.
    Arrange a hierarchy that fits your site and data.
    Write data sources.
    Use your Hiera data in Puppet (or any other tool).

## Slide 6

This is a sample hiera.yaml configuration file for Hiera. Use this file to configure the hierarchy, which backend(s) to use, and settings for each backend.

Hiera’s config file must be a YAML hash. The file must be valid YAML, but may contain no data.

Hiera will fail with an error if the config file can’t be found, although an empty config file is allowed.


:backends
Must be a string or an array of strings, where each string is the name of an available Hiera backend. The built-in backends are yaml and json; an additional puppet backend is available when using Hiera with Puppet. Additional backends are available as add-ons.
The list of backends is processed in order: in the example above, Hiera would check the entire hierarchy in the yaml backend before starting again with the json backend.
Default value: "yaml"

:hierarchy
Must be a string or an array of strings, where each string is the name of a static or dynamic data source. (A dynamic source is simply one that contains a %{variable} interpolation token. See “Creating Hierarchies” for more details.)
The data sources in the hierarchy are checked in order, top to bottom.
Default value: "common" (i.e. a single-element hierarchy whose only level is named “common.”)

## Slide 7

Using the previous configuration we have created a data directory called dev.yaml. In this file we have 2 key/value pairs. One for ntpserver and an array for dnsservers.

## Slide 8

Hiera will search for key value pairs, for example the ntpserver key/value pair from our dev.yaml file, in the following order: 1. /etc/puppet/hieradata/hosts/agent.puppetlabs.vm.yaml
2. /etc/puppet/hieradata/env/dev.yaml 
3. /etc/puppet/hieradata/common.yaml

## Slide 9

While this has been a short and simple introduction to Hiera, you can hopefully see the advantages of separting your common configuration data from your modules.

Remember, with Hiera, you can:
    Write common data for most nodes
    Override some values for machines located at a particular facility…
    …and override some of those values for one or two unique nodes.
This way, you only have to write down the differences between nodes. When each node asks for a piece of data, it will get the specific value it needs.

## Slide 10





## Exercises
1. The `/etc/motd` file is presented to users each time they log in. We would like to allow non-admins to easily customize this login message.

Familiarize yourself with the hiera.yaml configuration file:

`vim /etc/puppetlabs/puppet/hiera.yaml`

2. Identify the `datadir` where yaml configuration files are located. Edit the `common.yaml` datasource, which will set common values for all nodes in your environment and set an motd key to define your `/etc/motd` message:

`vim /etc/puppetlabs/puppet/hieradata/common.yaml`

3. Keys can be retrieved with the `hiera()` function. Verify that your key is set properly by running puppet and executing that function inline:

`puppet apply -e 'notice(hiera("motd"))'`

4. Change your current working directory to your module path:

`cd /etc/puppetlabs/puppet/modules`

5. Examine the directory structure of the example motd module:

<pre><code>[root@training modules]# tree motd/
motd/
├── manifests
│   └── init.pp
├── Modulefile
├── README
├── spec
│   └── spec_helper.rb
└── tests
    └── init.pp
</pre>

6. Edit the main class manifest file and replace the value of the content parameter with a `hiera()` function call to look up the data dynamically:

`vim motd/manifests/init.pp`

7. Validate your syntax and enforce your class. and apply the class. Your `/etc/motd` file should contain the data retrieved from your `common.yaml` datasource.

*   `puppet parser validate motd/manifests/init.pp`
*   `puppet apply motd/tests/init.pp`

8. Looking at the `hiera.yaml` file again, identify the datasource that would provide an override for your node’s fully qualified domain name. This fqdn can be found by executing `facter fqdn`.

9. Create that file, and provide an alternate motd message. Without making any changes to your manifest, enforce it again and verify that the overridden message is propagated to your `/etc/motd` file.

## Quiz
1. True or False. Hiera is primarily useful in separating configuration data from your Puppet modules. (True)

2. Which of the following is not a benefit, as listed in the video?
	a. Hiera makes it easier to configure your own nodes.
	b. Hiera makes it easier to re-use public Puppet modules.
	c. **Hiera makes it easier to configure your Puppet Master during installation.**
	d. Hiera makes it easier to publish your own modules.

3. True or False. Hiera allows for PostgreSQL backends. (True)

4. When searching the data backends Hiera will:
	a. **Begin with the first backend listed.**
	b. Search all backends listed.
	c. Randomly search the backends listed.
	d. Traverse the listed backends from bottom up.

5. True or False. The Hiera configuration file must be a valid YAML hash file. (True)

## Resources
* [Hiera - Github](https://github.com/puppetlabs/hiera)
* [Hiera - Docs](http://docs.puppetlabs.com/hiera/1/)
* [Hiera - Project Page](http://projects.puppetlabs.com/projects/hiera)
