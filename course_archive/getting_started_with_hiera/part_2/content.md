<script defer="[]" src="//code.jquery.com/jquery-1.11.2.js"></script>

<script defer="[]" src="https://try.puppet.com/js/selfpaced.js"></script>

<div id="lesson">

<div id="instructions">

<h3 class="instruction-header">
  <strong>
    <i class="fa fa-graduation-cap"></i> Lesson
  </strong>
</h3>

<div class="instruction-content">

<p>Hiera is pretty handy for keeping all of your data in one place, when you add a
level of hierarchy it becomes a lot more powerful.</p>

<p>Let&#8217;s imagine you have two webservers, one is in your &#8220;prod&#8221; app tier and one 
is in your &#8220;dev&#8221; app tier.  They are mostly the same, but they need to use 
different DNS servers.</p>

<p><strong>Note: In Puppet, the word <code>environment</code> refers to a set of Puppet code that
applies to a certain set of nodes.  We use the term <code>app tier</code> to refer to a
physical set of nodes. This distinction isn&#8217;t important for this course but it
becomes important when using recommended best practices for managing Puppet code.</strong></p>

<p>Without Hiera, your code might look like this:</p>
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
dns_server =&gt; $dns_server,
}
</pre>

<p>This is simple enough for two servers. What if you add developer workstations
or another pre-production test app tier? What if there are more configuration
differences between app tiers? The code can quickly get out of
control.</p>

<p>Let&#8217;s look at how the code would appear in using Hiera:</p>
<pre>
$dns_server = hiera('$dns_server')
profile::dns_server {
dns_server =&gt; $dns_server,
}
</pre>

<p>So what happened to the details? Now they&#8217;re in two separate files, one for
each app tier. They go in the same directory as <code>common.yaml</code></p>

<p>Here&#8217;s the prod tier datasource, we&#8217;ll call it <code>prod.yaml</code></p>
<pre>
---
dns_server: 'proddns.puppetlabs.vm'
</pre>

<p>And here&#8217;s the dev tier datasource, we&#8217;ll call it <code>dev.yaml</code></p>
<pre>
---
dns_server: 'devdns.puppetlabs.vm'
</pre>

<p>You&#8217;ll need to tell Hiera how to use these two files by editing your
hiera.yaml file. You&#8217;ll have to add another level to the hierarchy,
above &#8220;common&#8221;. Since we want to use the value of the app tier fact
and not just the word &#8220;app_tier&#8221;, we&#8217;ll need to add some special syntax.</p>

<p>Here&#8217;s what the <code>hiera.yaml</code> needs to look like:</p>
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

<p>Don&#8217;t worry if you&#8217;re confused by the syntax at this point, we&#8217;ll talk about
it more later on. Note the other places in the file where the same syntax
is used.</p>

</div>

<h3 class="instruction-header">
  <strong>
    <i class="fa fa-desktop"></i> Practice
  </strong>
</h3>

<div class="instruction-content">

<p>Before we go further, why not try out what you&#8217;ve just learned?</p>

<p>First, run <code>puppet agent -t</code> to set up the node for this lesson.</p>

<p>We&#8217;ve set a custom fact of <code>app_tier=prod</code> so you can see what hiera will return
for the <code>prod</code> app tier by using this command:</p>

<pre>
puppet apply -e "notify{hiera('dns_server'):}"
</pre>

<p>To test out other app_tiers, try using the hiera command line tool. The <code>hiera</code>
comand line tool lets you specify the values for facts to test out results. This
tool doesn&#8217;t have any facts by default, so we also need to specify environment.</p>

<p>To see what the value would be for dev use this command:</p>
<pre>
hiera dns_server ::app_tier=dev environment=production
</pre>

</div>

<h3 class="instruction-header">
  <strong>
    <i class="fa fa-check-square-o"></i> Instructions
  </strong>
</h3>

<div class="instruction-content">

<p>Try adding another app tier called <code>qa</code>, or even another level in the
hierarchy that&#8217;s based on the <code>hostname</code> fact instead of <code>app_tier</code>.</p>

<p>Remember, <code>hostname</code> is a built in fact to find your hostname run
<code>facter hostname</code>.</p>

</div>

</div>

<div id="terminal">
<iframe id="try" src="https://try.puppet.com/sandbox/?course=get_hiera2" name="terminal"></iframe>
</div>

</div>