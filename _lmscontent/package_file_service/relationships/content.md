Now that you've written resources to install the required packages, modify the configuration files and start the services, it is important to make sure that Puppet applies those changes in the correct order on your servers.

When following a runbook, you enter the commands in the order given, but with Puppet, resources are applied in a certain order by specifying resource relationships between them. It's important to know that you don't have to specify a relationship between every resource that you write, just the ones that are order-dependent.

For instance, you have to install a package before attempting to modify a configuration file contained in that package. Similarly, you have to modify a configuration file before attempting to start a service that reads that file.

Consider part of the scenario you've been following:

* You want to deploy an application called Robby.

* You install Robby using the `robby` package.

* After you install Robby, you configure it by changing settings in `/etc/robby/robby.cfg`.

* After you configure Robby, start the `robby` service to start your application.

This is a common scenario for server software such as IIS, MySQL, Tomcat, or Redis. In all cases, you have to consider ordering. Puppet must first install the package, then edit the configuration file, and finally attempt to start the service. Otherwise, if Puppet tried a service that wasn't yet installed, it would generate an error like "No such service exists". You can be very explicit about this ordering in your code.

Example:

<pre>
package { 'robby':
  ensure =&gt; installed,
}

file { '/etc/robby/robby.cfg':
  ensure  =&gt; file,
  content =&gt; "welcome_msg = Welcome to Robby, running on ${hostname}!",
  require =&gt; Package['robby'],
}
</pre>

The `require` attribute tells Puppet that the file resource needs the package resource to go first. Alternately, this can be written as:

<pre>
package { 'robby':
  ensure =&gt; installed,
  before =&gt; File['/etc/robby/robby.cfg'],
}

file { '/etc/robby/robby.cfg':
  ensure  =&gt; file,
  content =&gt; "welcome_msg = Welcome to Robby, running on ${hostname}!",
}
</pre>

This example uses the `before` attribute to tell Puppet that the package resource must go before the file resource. Ultimately, these two examples do the exact same thing. Depending on your preference, you can write it either way.

> **Pro Tip:**

> When referring to another resource using `before` or `require`, the resource type is capitalized. Be sure you also note the syntax used for defining relationships:

**Puppet code block labelled with relationship, type, and title on bottom line of code block.**

###### Enlarge image

## Task:

Add `before` or `require` to the following code so that the package resource is managed first and the file resource is managed second.

<iframe src="https://magicbox.classroom.puppet.com/pfs/package_file" width="100%" height="500px" frameborder="0"></iframe>

## Task:

Add `before` or `require` to the following code so that the `postgresql-server` package resource is managed first and the `postgresql.conf` file resource is managed second.

<iframe src="https://magicbox.classroom.puppet.com/scenario/package_file" width="100%" height="500px" frameborder="0"></iframe>
