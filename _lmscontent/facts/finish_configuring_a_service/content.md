Now that you've learned more about Puppet facts, write some Puppet code to create the `robby.cfg` file containing the proper content where *HOSTNAME* should be replaced with the actual name of the server using a fact:

`welcome_msg = Welcome to Robby, running on HOSTNAME!`

## Task:
<p><iframe src="https://magicbox.classroom.puppet.com/syntax/modifying_the_system" width="100%" height="500px" frameborder="0"></iframe>
</p>

Notice that as you are developing your Puppet source code, you have multiple resources that will be applied to each of the servers. Since the runbook specified the steps in a certain order, it's important to make sure that Puppet applies changes to your servers in the same order. This can be achieved with resource relationships.
