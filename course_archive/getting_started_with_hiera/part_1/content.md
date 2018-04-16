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
<p>When you first start using Puppet, you might include configuration details in
your Puppet code.  For example, when setting up a database server, you might
hard-code the hostname of the server in the Puppet manifest. As your Puppet
implementation grows, this can become unmanageable. Making a small change to a
system might mean making changes across multiple parts of your Puppet code.
Hiera offers a robust and straightforward way to separate data from code.</p>

<p>The name &#8216;Hiera&#8217; stands for hierarchy, but the most basic functional Hiera
config doesn&#8217;t have to be hierarchical.  Let&#8217;s set up a simple flat lookup using
Hiera.</p>

<p>Imagine you want to set a default message of the day on your servers.  You
could do this with the following Puppet code:</p>

<pre>
$message = "Welcome to try.puppet.com. Don't break anything!"
file { '/etc/motd':
content =&gt; $message
}
</pre>

<p>This works just fine, but the more you hard-code data into your Puppet code,
the harder it is to maintain.  What if you wanted to share that code with
someone outside your company? You&#8217;d have to remember to go in and clean out any
potentially sensitive data across your entire codebase.</p>

<p>Even with the simplest configuration, Hiera offers a robust way to separate that
data from your code.</p>

<p>Using Hiera, the code would look this this:</p>
<pre>
$message = hiera('message')
file { '/etc/motd':
content =&gt; $message
}
</pre>

<p>You&#8217;ll need to tell Hiera where to find the data, this is done with the
<code>/etc/puppetlabs/puppet/hiera.yaml</code> file.  The file Puppet installs by default
will work:</p>

<pre>
---
:backends:
- yaml
:hierarchy:
- "nodes/%{::trusted.certname}"
- common
:yaml:
# datadir is empty here, so hiera uses its defaults:
# - /etc/puppetlabs/code/environments/%{environment}/hieradata on *nix
# - %CommonAppData%\PuppetLabs\code\environments\%{environment}\hieradata on Windows
# When specifying a datadir, make sure the directory exists.
:datadir:
</pre>

<p>The lines starting with <code>#</code> are comments, and for now just ignore the first item
under <code>:hierarchy:</code>, we&#8217;re going to start with <code>common</code>. In future lessons, 
we&#8217;ll add some more levels and use the defaults more. We&#8217;ll keep &#8220;common&#8221; as 
the base of the hierarchy as a place to hold global defaults.</p>

<p>Notice in the comment about default <code>datadir</code> that it says your data will be in
<code>/etc/puppetlabs/code/environments/%{environment}/hieradata</code>.
<code>%{environment}</code> part will be interpolated by Puppet to refer to your code
environment.  The default is <code>production</code>, so that&#8217;s what we&#8217;ll use for this
exercise.</p>

<p>We still need to add the actual data. Do this by creating a file called
<code>common.yaml</code> in the <code>datadir</code> that&#8217;s listed in <code>hiera.yaml</code></p>

<p><code>common.yaml</code> looks like this:</p>
<pre>
---
message: "Welcome to %{fqdn} Don't break anything!"
</pre>

<p>Just like we use <code>%{environment}</code> the <code>%{fqdn}</code> will be interpolated as the
fully qualified domain name of your node.</p>

</div>

<h3 class="instruction-header">
  <strong>
    <i class="fa fa-desktop"></i> Practice
  </strong>
</h3>

<div class="instruction-content">

<p>Now that you have a sense of the basic config, try adding another key/value
pair to the <code>common.yaml</code> on your agent node. Experiment with changing things
to see what results you get. Don&#8217;t worry if you break something, just reload
the page to get a fresh machine.</p>

</div>

<h3 class="instruction-header">
  <strong>
    <i class="fa fa-check-square-o"></i> Instructions
  </strong>
</h3>

<div class="instruction-content">
<p>If you haven&#8217;t already, run <code>puppet agent -t</code> to set up your node with
example code.</p>

<p><strong>Note: You will see a notice about your code environment not matching the server. 
This is because nodes ask for &#8220;production&#8221; by default, but we&#8217;ve set up a
code environment just for your node.</strong></p>

<p>To test out Hiera, you can use make a simple manifest like the examples above
and use <code>puppet apply</code>. The notify resource can be handy for this.  For example, 
to lookup the value of &#8220;message&#8221;, create a file <code>/root/message.pp</code>:</p>

<pre>
notify{hiera('message'):}
</pre>

<p>To see the hiera value run <code>puppet apply /root/message.pp</code></p>

<p>Add a second key by editing <code>/etc/puppetlabs/code/environments/production/hieradata/common.yaml</code></p>

<p>You node has <code>vim</code> already installed and you can install others such as <code>nano</code>
by using the command <code>puppet apply -e "package{'nano': ensure =&gt; present}"</code></p>
</div>

<h3 class="instruction-header">
  <strong>
    <i class="fa fa-pencil"></i> Notes
  </strong>
</h3>

<div class="instruction-content">

<p>Hiera data should live on the Puppet master. For learning how hiera works, 
we&#8217;re editing code on the agent and using <code>puppet apply</code>.</p>

<p>If you make a mistake and would like a fresh practice environment, type
<code>exit</code> and click the <code>start session</code> button when it appears.</p>

<p>We&#8217;ve provided the courses Introduction to the Linux Command Line and 
An Introduction to Vim in case you need a refresher.</p>

</div>

</div>

<div id="terminal">
<iframe id="try" src="https://try.puppet.com/sandbox/?course=get_hiera1" name="terminal"></iframe>     
</div>

</div>