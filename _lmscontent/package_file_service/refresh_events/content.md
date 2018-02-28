## Introduction:
You have seen ways to edit an application's configuration file before you start its service. But what if you need to make a change to a service that is already running? Most software requires a restart after you edit the configuration file for that change to take effect. Puppet allows you to refresh using the <code>subscribe</code> or <code>notify</code>&nbsp;attributes.

Puppet lets you use <code>notify</code> and <code>subscribe</code> to not only order resources, but send a **refresh**. Refreshing a resource means different things depending on the resource type. For example, when you refresh a service resource type, Puppet restarts the service. And when you refresh a mount resource type, Puppet remounts a file mount. You can try to refresh any type in Puppet, but not all of them will respond. Read the [Puppet docs](https://puppet.com/docs/puppet/5.3/lang_relationships.html#refreshing-and-notification "") for more information about refreshing and notification.

Example:

<div>
<pre><code class="language-none">package { 'myapp':
  ensure =&gt; installed,
}
file { '/myapp/config.json':
  ensure  =&gt; file,
  content =&gt; '{ "configuration": "some setting"}',
  require =&gt; Package['myapp']
}
service { 'myapp':
  ensure    =&gt; running,
  subscribe =&gt; File['/myapp/config.json'],
}</code></pre>
</div>
In this example, the <code>subscribe</code> attribute tells Puppet to manage the file resource before the service resource and to restart the service if the file resource changes. This can also be written like the following example:

<div>
<pre><code class="language-none">package { 'myapp':
  ensure =&gt; installed,
  before =&gt; File['/myapp/config.json'],
}
file { '/myapp/config.json':
  ensure  =&gt; file,
  content =&gt; '{ "configuration": "some setting"}',
  notify  =&gt; Service['myapp'],
}
service { 'myapp':
  ensure    =&gt; running,
}</code></pre>
</div>
This example uses the <code>notify</code> attribute instead of <code>subscribe</code> but the outcome is the same.

If you want to use <code>before</code> and also send a refresh, use <code>notify</code>. If you want to use <code>require</code> and also receive a refresh, use <code>subscribe</code>.

## Task:
Add <code>notify</code> or <code>subscribe</code> to the following code so that the service is restarted if the file resource is changed.

<iframe src="https://magicbox.classroom.puppet.com/pfs/file_service" width="100%" height="500px" frameborder="0" />
