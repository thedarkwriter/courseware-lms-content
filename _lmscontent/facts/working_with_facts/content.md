## Introduction:
Most facts contain a single value like <code>"hostname":</code> <code>"host.puppet.com"</code> or <code>"kernel": "Linux"</code>. One way to use these facts is to create server-specific attributes.

Example:

<div>
<pre><code class="language-none">file { '/etc/motd':
  content =&gt; "My hostname: ${hostname}",
}</code></pre>
</div>
In this example, any system using this code will have its own hostname printed into the file. In this way, you can have server-specific outcomes with a single piece of code. This means you don't have to rewrite your code for every single machine you're managing.

## Task:
<iframe src="https://magicbox.whatsaranjit.com/facts/working_with_facts" width="100%" height="500px" frameborder="0" />