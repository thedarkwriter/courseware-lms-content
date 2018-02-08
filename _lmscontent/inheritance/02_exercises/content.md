<p>Login shells are the programs that users interact with. They interpret commands typed at the command line. We would like to provide a new shell for our users, and we’ll customize the configuration file a bit for all of our users. We would also like to customize this default configuration file for a subset of our users to provide handy shortcuts and aliases that are useful for software developers.</p>
<p>Change your current working directory to your modulepath with</p>
<p><code>cd /etc/puppetlabs/puppet/modules</code></p>
<p>Examine the directory structure of the example zsh module.</p>
<pre><code>[root@training modules]# tree zsh/
zsh/
├── files
│   ├── zshrc
│   └── zshrc.dev
├── manifests
│   └── init.pp
├── Modulefile
├── README
├── spec
│   └── spec_helper.rb
└── tests
    └── init.pp</code></pre>

<p>We will start with this zsh module that manages the shell.  Create a new class called <code>zsh::developer</code> that inherits from the <code>zsh</code> class and overrides the <code>File['/etc/zshrc']</code> resource to change the location that the file is sourced from to <code>puppet:///modules/zsh/zshrc.dev</code></p>
<ul>
<li><code>cd /etc/puppetlabs/puppet/modules</code></li>
<li><code>vim zsh/manifests/developer.pp</code></li>
</ul>
<p>Also create a test manifest in order to verify your code.</p>
<p><code>vim zsh/tests/developer.pp</code></p>
<p>Finally, incorporate the ordering from the <a href="https://dev.puppetlabs.com/learn/relationships">Relationships</a> lesson to ensure that the configuration file is written out after the package is installed. To do so, edit the main <code>zsh</code> class:</p>
<p><code>vim zsh/manifests/init.pp</code></pre>
<p>and add a <code>before</code> attribute to the <code>Package['zsh']</code> resource</p>
<p><code>before => File['/etc/zshrc'],</code></p>
<p>Test and enforce your test manifest.</p>
<ul>
<li><code>puppet parser validate zsh/manifests/developer.pp</code></li>
<li><code>puppet apply zsh/tests/developer.pp</code></li>
</ul>
</div></div></div>  </div>

  
  </div>
<div class="panel-separator"></div><div class="ctools-collapsible-container ctools-collapsed"><h2 class="pane-title ctools-collapsible-handle">Example Solution</h2><div class="ctools-collapsible-content"><div class="field field-name-field-example-solutions field-type-text-long field-label-hidden"><div class="field-items" id="md4"><div class="field-item even"><pre><code># /etc/puppetlabs/puppet/modules/zsh/manifests/developer.pp
class zsh::developer inherits zsh {
  File['/etc/zshrc'] {
    source => 'puppet:///modules/zsh/zshrc.dev',
  }
}</code></pre>
<pre><code># /etc/puppetlabs/puppet/modules/zsh/tests/developer.pp
include zsh::developer</code></pre>