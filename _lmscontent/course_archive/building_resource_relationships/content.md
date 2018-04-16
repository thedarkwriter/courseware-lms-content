Now that you've written resources to install the required packages and modify the configuration files, it is important to make sure that 
Puppet applies those changes in the correct order on your servers. Otherwise, if Puppet tried a service that wasn't yet installed, it 
would generate an error like <q>No such service exists.</q> 

When following a runbook, you enter the commands in the order given. But with Puppet, resources are applied in a certain order by 
specifying resource relationships between them. It's important to know that you don't have to specify a relationship between every 
resource that you write, just the ones that are order dependent. 
Puppet must first install the package, then edit the configuration file, and finally attempt to start the service. For instance, you have 
to install a package before attempting to modify a configuration file contained in that package. Similarly, you have to modify a 
configuration file before attempting to start a service that reads that file.

Now create resource relationships according to the runbook ordering instructions:

- On db1 and db2, install the postgresql-server package and the modify the postgresql.conf file
- On web1, web2 and web3, install the httpd package, then install the robby package and then modify the /etc/robby/robby.cfg file
- On lb1, install the haproxy package and then modify the /etc/haproxy/haproxy.cfg file

Example:

<div>
<pre><code class="language-none">package { 'myapp':
  ensure =&gt; installed,
}
file { '/myapp/config.json':
  ensure  =&gt; file,
  content =&gt; '{ "configuration": "some setting"}',
  require =&gt; Package['myapp'],
}</code></pre>
</div>
The <code>require</code> attribute tells Puppet that the file resource needs the package resource to go first. Alternately, this can be written as:

<div>
<pre><code class="language-none">package { 'myapp':
  ensure =&gt; installed,
  before =&gt; File['/myapp/config.json'],
}
file { '/myapp/config.json':
  ensure  =&gt; file,
  content =&gt; '{ "configuration": "some setting"}',
}
</code></pre>
</div>
This example uses the <code>before</code> attribute to tell Puppet that the package resource must go before the file resource. 
Ultimately, these two examples do the exact same thing. Depending on your preference, you can write it either way.

<blockquote>
**Pro Tip:**

When referring to another resource using <code>before</code> or <code>require</code>, the resource type is capitalized. Be sure you also 
note the syntax used for defining relationships:

</blockquote>
Puppet code block labelled with relationship, type, and title on bottom line of code block.

## Task:
Add <code>before</code> or <code>require</code> to the following code so that the package resource is managed first and the file resource 
is managed second.

<iframe src="https://magicbox.classroom.puppet.com/pfs/package_file" width="100%" height="500px" frameborder="0"></iframe>

Next, the various services must be started on the different servers - PostgreSQL on the database servers, Apache and Robby on the web 
servers and HAProxy on the load balancer. The service names to be started are:

On db1 and db2:

```postgresql```

On web1, web2, and web3:

```httpd```
```robby```

On lb1:

```haproxy```

As discussed previously, we must ensure that Puppet applies changes to the target servers in the same order specified in the runbook. 
Also, we must make sure that the service configuration files are modified by Puppet before it attempts to start the corresponding 
services. As before, we have to add resource relationships between the configuration file resources and the service resources. 

Puppet lets you use <code>notify</code> and <code>subscribe</code> to not only order resources, but send a **refresh**. Refreshing a 
resource means different things depending on the resource type. For example, when you refresh a service resource type, Puppet restarts 
the service. And when you refresh a mount resource type, Puppet remounts a file mount. You can try to refresh any type in Puppet, but not 
all of them will respond. Read the [Puppet docs](https://puppet.com/docs/puppet/latest/lang_relationships.html#refreshing-and-notification 
"") for more on refreshing and notification.
