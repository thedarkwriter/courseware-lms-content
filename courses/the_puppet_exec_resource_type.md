<link rel="stylesheet" href="/static/selfpaced/selfpaced.css" markdown="1">
<script src="https://try.puppet.com/js/selfpaced.js" markdown="1"></script>

<div id="lesson" markdown="1">
<div id="instructions" markdown="1">
<div class="instruction-header" markdown="1">
<i class="fa fa-graduation-cap" markdown="1"></i>
Lesson
</div>
<div class="instruction-content" markdown="1">
<!-- Primary Text of the lesson -->
<!-------------------------------->


# The Exec Resource
The Puppet exec resource allows you to execute a command directly using Puppet. It is the most versatile resource because it can do anything that the underlying operating system can do. That versatility makes it tempting to use, but the exec should really only be used as a last resort. If there isn't a built in resource type that does what you need, there is often one provided by a module on the forge. Before writing an exec, always check the forge.

To learn to use the exec resource properly, it's important to begin with the idea of desired state. Imagine you have a script called `webuser` that manages users for a web app and it can't be easily replaced with Puppet code because it contains some complex business logic. The hypothetical `webuser` script has a couple of command line options: `webuser add <username>` creates a new user, `webuser check <username>` returns info about that user or an error if your user doesn't exist, and `webuser del <username>` deletes the user.

If you wanted to write puppet code to create a user with that script, you'd first think of the desired state, i.e. the user exists. How would you know the user exists? The `webuser check` command returns information and an exit code of 0.  The exec resource has two parameters for defining this: `unless` and `onlyif`. For creating a user, we want the exec to run `unless` the `webuser check username` command returns a user. So the exec resource would look something like this:

<pre>
exec {'webuser add bob':
  unless => 'webuser check bob',
  path   => '/usr/local/bin',
} 
</pre>

*Notice the `path` parameter. This is required for execs unless you specify the full path everywhere it's needed. Setting the path parameter makes the code more readable.*

Because we started thinking about this from the desired state and included that logic in the exec, this code is idempotent. This means you can run it multiple times and it will only attempt to create the user once.

The same thing could be done for deleting the user this time using the `onlyif` parameters:
<pre>
exec {'webuser del bob':
  onlyif => 'webuser check bob',
  path   => '/usr/local/bin',
} 
</pre>

The above resource declaration will only delete the user if it already exists, otherwise it does nothing.

The `creates` parameter is a third option. If the file referenced by `creates` doesn't exist, the exec will run. For this parameter to work, the exec command itself will need to create a file. A common example is an exec to unzip a file would create the unzipped version of that file. So on later Puppet runs, it will see that the file already exists and not trigger the exec command again.

Every exec resource should have one of these parameters to check the desired start so the exec isn't run unless it's needed.

Sometimes, it isn't possible to check the desired state, for example if our webapp had a `webupdate` command that needed to be run when a config file had changed. We don't have a simple way of checking the desired state in that case. You can still prevent the exec from triggering on every Puppet run by using the `refreshonly` parameter. If the `refreshonly` parameter is set to `true` the exec command will only run if it has a `notify` or `subscribe` relationship with another resource. That is, the exec will only run if it has another resource specified in the `subscribe` parameter, or if another resource has a `notify` directed at the exec.

For example:
<pre>
file {'/etc/webapp/settings.conf':
  source => 'puppet:///webapp/settings.conf',
}
exec {'webupdate':
  refreshonly => true,
  path        => '/usr/local/bin',
  subscribe   => File['/etc/webapp/settings.conf'],
}
</pre>

The exec will only be triggered if the file changes.
Alternatively, the same relationship could be specified the other way:

<pre>
file {'/etc/webapp/settings.conf':
  source => 'puppet:///webapp/settings.conf',
  notify => Exec['webupdate'],
}
exec {'webupdate':
  refreshonly => true,
  path        => '/usr/local/bin',
}
</pre>

`notify` and `subscribe` are two syntax options for creating the same type of relationship. Choose the option that makes the most sense to you. There is no difference in the compiled catalog between an `exec` that's subscribed to a `file` and a `file` that notifies an `exec`.

There are several other parameters that can be set on the exec resource, such as `cwd` to set the working directory for the command, and `user` to set the user to run the command. The details about all of the built in types can be found here: [Puppet Docs - Type Reference](https://docs.puppet.com/references/latest/type.html). If you're managing Windows machines you should also look the the [tips and examples for using Exec resources on Windows](https://docs.puppet.com/puppet/latest/reference/resources_exec_windows.html)


<!-- End of primary test of the lesson -->
</div>
<div class="instruction-header" markdown="1">
<i class="fa fa-desktop"></i>
Practice
</div>
<div class="instruction-content" markdown="1">
<!-- High level description of the exercise. -->
<!-------------------------------------------->



Run `puppet agent -t` to load the example code on to your agent node.

We've installed a few scripts to demonstrate different ways of using the exec resource. One is the `webuser` script mentioned in the lesson. Try out the examples above until you get the hang of it.

There is also an example `.tar` file in /root. Create an exec resource to run `tar -xf` on that file and use the `creates` parameter to be sure it only happens once.

Once you feel comfortable with exec resources, try opening the `/usr/bin/webuser` script to see if it can replaced with puppet code that doesn't use the exec resource type.



</div>

<div class="instruction-header" markdown="1">
<i class="fa fa-pencil"></i>
Notes
</div>

</div>
<div id="terminal" markdown="1">
  <iframe id="try" name="terminal" src="https://try.puppet.com/sandbox/?course=exec"></iframe>
</div>
</div>
