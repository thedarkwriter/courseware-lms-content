If you've ever learned a coding language or started a blog, chances are that you started by learning how to display the phrase "Hello world". Well, that is exactly what we are going to do using Puppet code. The purpose of this exercise is for you to try out writing some Puppet code to see that it doesn't have to be complicated. In fact, it can be fun!

This is what Hello world looks like written in Puppet code:

<img src="https://learn.puppet.com/static/images/courses/syntax/329-puppet-code-explained.png" width=100% height=100% alt="The first line, file { '/etc/motd':, tells Puppet that we will be managing the /etc/motd file on our system. The second line, content => 'Hello world', tells Puppet to set the contents of the /etc/motd file to the text 'Hello world' using the content attribute. The third line, }, closes the code block and tells Puppet that we're done managing the /etc/motd file.">

## Task:

Now it's your turn to write Hello world using Puppet code. Type the example code from above into the box below.

<iframe src="https://magicbox.classroom.puppet.com/syntax/hello_world" width="100%" height="500px" frameborder="0"></iframe>
