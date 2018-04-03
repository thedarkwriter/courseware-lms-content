<div class="panel-separator"></div><div class="ctools-collapsible-container ctools-collapsed"><h2 class="pane-title ctools-collapsible-handle">Example Solution</h2><div class="ctools-collapsible-content"><div class="field field-name-field-example-solutions field-type-text-long field-label-hidden"><div class="field-items" id="md4"><div class="field-item even"><pre><code># /etc/puppetlabs/puppet/hieradata/common.yaml
---
motd: Hello there! This machine is managed by Puppet.</code></pre>
<pre><code># /etc/puppetlabs/puppet/modules/motd/manifests/init.pp
class motd {
  file { '/etc/motd':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => hiera('motd'),
  }
}</code></pre>
</div></div></div></div></div>