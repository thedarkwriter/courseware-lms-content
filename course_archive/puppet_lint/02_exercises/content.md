<li>Run puppet-lint on the sample manifest file.</li>
</ul>

<p><code>puppet-lint /etc/puppetlabs/puppet/modules/ntplint/manifests/init.pp</code></p>

<ul>
<li>Puppet-lint will return the following list of warnings:</li>
</ul>

<pre><code>
   WARNING: top-scope variable being used without an explicit namespace on line 5

   WARNING: double quoted string containing no variables on line 10

   WARNING: string containing only a variable on line 39

   WARNING: unquoted resource title on line 38

   WARNING: ensure found on line but it's not the first attribute on line 40

</code></pre>

<ul>
<li>Edit the manifest to correct these issues:</li>
</ul>

<p><code>vim /etc/puppetlabs/puppet/modules/ntplint/manifests/init.pp</code></p>

<ul>
<li>Run puppet-lint again to see the result:</li>
</ul>

<p><code>puppet-lint /etc/puppetlabs/puppet/modules/ntplint/manifests/init.pp</code></p>

<ul>
<li>Continue editing and checking until there are no remaining warnings. </li>
</ul>