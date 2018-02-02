<body>

## Introduction:

This type manages services running on the node. Some important attributes include <code>name</code>, <code>ensure</code>, <code>enable</code>, <code>hasrestart</code>, and <code>hasstatus</code>.

<div><pre><code class="language-none">service { &#39;sshd&#39;:
  ensure =&gt; running,
  enable =&gt; true,
}</code></pre></div>

## Task:

Enter the <code>puppet resource</code> command to see all the attributes of the <code>service</code> named <code>puppet</code>.

<iframe src="https://magicbox.whatsaranjit.com/resources/exploring_service" width="100%" height="500px" frameborder="0" />

</body>