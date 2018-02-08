## Introduction:
Now that you have looked at the package, file, and service resource types, try using them together. Consider the following scenario:

* 
You want to deploy an application called Myapp.

* 
You can install Myapp using the myapp package.

* 
After you install myapp, you can configure it by editing settings in <code>/myapp/config.json</code>.

* 
After you configure Myapp, start the myapp service to start your application.

This is a common scenario for software such as IIS, MySQL, Tomcat, or Redis. In all cases, you have to consider ordering. Puppet must first install the package, then edit the configuration file, and finally attempt to start the service. Otherwise, if Puppet tried a service that wasn't yet installed, it would generate an error like <q>No such service exists.</q> You can be very explicit about this ordering in your code.

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
This example uses the <code>before</code> attribute to tell Puppet that the package resource must go before the file resource. Ultimately, these two examples do the exact same thing. Depending on your preference, you can write it either way.

<blockquote>
**Pro Tip:**

When referring to another resource using <code>before</code> or <code>require</code>, the resource type is capitalized. Be sure you also note the syntax used for defining relationships:

</blockquote>
Puppet code block labelled with relationship, type, and title on bottom line of code block.

###### Enlarge image
## Task:
Add <code>before</code> or <code>require</code> to the following code so that the package resource is managed first and the file resource is managed second.

<iframe src="https://magicbox.whatsaranjit.com/pfs/package_file" width="100%" height="500px" frameborder="0" />