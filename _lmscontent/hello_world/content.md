<h2 id="toc_0">Introduction:</h2>
<p>If you’ve ever learned a coding language or started a blog, chances are that you started by learning how to display the phrase Hello, World. Well, that is exactly what we are going to do using Puppet code. The purpose of this exercise is for you to try out writing some Puppet code to see that it doesn’t have to be complicated—in fact, it can be fun!</p>
<p>This is what Hello world looks like written in Puppet code:</p>
<img src="https://learn.puppet.com/static/images/courses/syntax/329-puppet-code-explained.png" width=100% height=100% alt="The first line, file { '/etc/motd':, tells Puppet that we will be managing the /etc/motd file on our system. The second line, content => 'Hello world', tells Puppet to set the contents of the /etc/motd file to the text 'Hello world' using the content attribute. The third line, }, closes the code and tells Puppet that we're done managing the /etc/motd file.">
<h2 id="toc_1">Task:</h2>
<p>Now it&rsquo;s your turn to write Hello world using Puppet code. Type the example code from above into the box below.</p>
<p><iframe src="https://magicbox.classroom.puppet.com/syntax/hello_world" width="100%" height="500px" frameborder="0"></iframe></p>
