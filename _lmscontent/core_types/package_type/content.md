## Introduction:
This type manages software packages. Some important attributes of this type include <code>name</code>, <code>ensure</code>, <code>source</code>, and <code>provider</code>. For example:

<div>
<pre><code class="language-none">package { 'openssh-server':
  ensure =&gt; installed,
}</code></pre>
</div>
## Task:
Enter the <code>puppet resource</code> command to see all the attributes of the <code>package</code> named <code>puppet</code>.

<iframe src="https://magicbox.whatsaranjit.com/resources/exploring_package" width="100%" height="500px" frameborder="0" />