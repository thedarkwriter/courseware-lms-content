You have now practiced creating resource relationships between a package and a file, and a file and service. Now put it all together in a common pattern called Package File Service.

This pattern tells Puppet to do the following:

1. First manage a package resource
2. Next manage a file resource
3. Finally manage a service resource

The service will also restart if the file resource changes at all.

Look at the below example. You will use the three resources and add the resource relationships to model the Package File Service pattern.

<div>
<pre><code class="language-none">package { 'httpd':
  ensure =&gt; installed,
}
file { '/etc/httpd/conf.d/httpd.conf':
  ensure  =&gt; file,
  content =&gt; 'Listen 80',
}
service { 'httpd':
  ensure =&gt; running,
}</code></pre>
</div>
## Task:
Add resource relationships to the following code so that the resources are managed in the order of package, file, service. The service should restart if the file resource is changed. You can choose between <code>before/require</code> and <code>notify/subscribe</code>.

<iframe src="https://magicbox.classroom.puppet.com/pfs/package_file_service" width="100%" height="500px" frameborder="0" />
