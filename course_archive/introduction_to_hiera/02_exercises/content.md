<p>The <code>/etc/motd</code> file is presented to users each time they log in. We would like to allow non-admins to easily customize this login message.</p>
<p>Familiarize yourself with the hiera.yaml configuration file.</p>
<p><code>vim /etc/puppetlabs/code/hiera.yaml</code></p>
<p>Identify the <code>datadir</code> where yaml configuration files are located. Edit the <code>common.yaml</code> datasource, which will set common values for all nodes in your environment and set an motd key to define your <code>/etc/motd</code> message.</p>
<p><code>vim /etc/puppetlabs/code/hieradata/common.yaml</code></p>
<p>Keys can be retrieved with the <code>hiera()</code> function. Verify that your key is set properly by running puppet and executing that function inline:</p>
<p><code>puppet apply -e 'notice(hiera("motd"))'</code></p>
<p>Change your current working directory to your modulepath</p>
<p><code>cd /etc/puppetlabs/code/modules</code></p>
<p>Examine the directory structure of the example motd module.</p>
<pre><code>[root@training modules]# tree motd/
motd/
+-- manifests
|   +-- init.pp
+-- Modulefile
+-- README
+-- spec
|   +-- spec_helper.rb
+-- tests
    +-- init.pp</code></pre>
<p>Edit the main class manifest file and replace the value of the content parameter with a <code>hiera()</code> function call to look up the data dynamically.</p>
<p><code>vim motd/manifests/init.pp</code></p>
<p>Validate your syntax and enforce your class. and apply the class. Your <code>/etc/motd</code> file should contain the data retrieved from your <code>common.yaml</code> datasource.</p>
<ul>
<li><code>puppet parser validate motd/manifests/init.pp</code></li>
<li><code>puppet apply motd/tests/init.pp</code></li>
</ul>
<p>Looking at the <code>hiera.yaml</code> file again, identify the datasource that would provide an override for your node's fully qualified domain name. This fqdn can be found by executing <code>facter fqdn</code>.
<p>Create that file, and provide an alternate motd message. Without making any changes to your manifest, enforce it again and verify that the overridden message is propagated to your <code>/etc/motd</code> file.</p>