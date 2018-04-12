<script src="https://try.puppet.com/js/selfpaced.js"></script>

<div id="lesson">
  <div id="instructions">
    <h3 class="instruction-header">
      <strong><i class="fa fa-graduation-cap"></i> Lesson</strong>
    </h3>
    <div class="instruction-content">
      <!-- Primary Text of the lesson -->
      <!-------------------------------->

      <h3 id="the-exec-resource">The Exec Resource</h3>
      <p>The Puppet exec resource allows you to execute a command directly using Puppet. It is the most versatile resource because it can do anything that the underlying operating system can do. That versatility makes it tempting to use, but the exec should really only be used as a last resort. If there isn&#8217;t a built in resource type that does what you need, there is often one provided by a module on the forge. Before writing an exec, always check the forge.</p>

      <p>To learn to use the exec resource properly, it&#8217;s important to begin with the idea of desired state. Imagine you have a script called <code>webuser</code> that manages users for a web app and it can&#8217;t be easily replaced with Puppet code because it contains some complex business logic. The hypothetical <code>webuser</code> script has a couple of command line options: <code>webuser add &lt;username&gt;</code> creates a new user, <code>webuser check &lt;username&gt;</code> returns info about that user or an error if your user doesn&#8217;t exist, and <code>webuser del &lt;username&gt;</code> deletes the user.</p>

      <p>If you wanted to write puppet code to create a user with that script, you&#8217;d first think of the desired state, i.e. the user exists. How would you know the user exists? The <code>webuser check</code> command returns information and an exit code of 0.  The exec resource has two parameters for defining this: <code>unless</code> and <code>onlyif</code>. For creating a user, we want the exec to run <code>unless</code> the <code>webuser check username</code> command returns a user. So the exec resource would look something like this:</p>

      <pre>
exec {'webuser add bob':
  unless =&gt; 'webuser check bob',
  path   =&gt; '/usr/local/bin',
} 
</pre>

      <p><em>Notice the <code>path</code> parameter. This is required for execs unless you specify the full path everywhere it&#8217;s needed. Setting the path parameter makes the code more readable.</em></p>

      <p>Because we started thinking about this from the desired state and included that logic in the exec, this code is idempotent. This means you can run it multiple times and it will only attempt to create the user once.</p>

      <p>The same thing could be done for deleting the user this time using the <code>onlyif</code> parameters:</p>
      <pre>
exec {'webuser del bob':
  onlyif =&gt; 'webuser check bob',
  path   =&gt; '/usr/local/bin',
} 
</pre>

      <p>The above resource declaration will only delete the user if it already exists, otherwise it does nothing.</p>

      <p>The <code>creates</code> parameter is a third option. If the file referenced by <code>creates</code> doesn&#8217;t exist, the exec will run. For this parameter to work, the exec command itself will need to create a file. A common example is an exec to unzip a file would create the unzipped version of that file. So on later Puppet runs, it will see that the file already exists and not trigger the exec command again.</p>

      <p>Every exec resource should have one of these parameters to check the desired start so the exec isn&#8217;t run unless it&#8217;s needed.</p>

      <p>Sometimes, it isn&#8217;t possible to check the desired state, for example if our webapp had a <code>webupdate</code> command that needed to be run when a config file had changed. We don&#8217;t have a simple way of checking the desired state in that case. You can still prevent the exec from triggering on every Puppet run by using the <code>refreshonly</code> parameter. If the <code>refreshonly</code> parameter is set to <code>true</code> the exec command will only run if it has a <code>notify</code> or <code>subscribe</code> relationship with another resource. That is, the exec will only run if it has another resource specified in the <code>subscribe</code> parameter, or if another resource has a <code>notify</code> directed at the exec.</p>

      <p>For example:</p>
      <pre>
file {'/etc/webapp/settings.cony':
  source =&gt; 'puppet:///webapp/settings.conf',
}
exec {'webupdate':
  refreshonly =&gt; true,
  path        =&gt; '/usr/local/bin',
  subscribe   =&gt; File['/etc/webapp/settings.conf'],
}
</pre>

      <p>The exec will only be triggered if the file changes.
Alternatively, the same relationship could be specified the other way:</p>

      <pre>
file {'/etc/webapp/settings.conf':
  source =&gt; 'puppet:///webapp/settings.conf',
  notify =&gt; Exec['webupdate'],
}
exec {'webupdate':
  refreshonly =&gt; true,
  path        =&gt; '/usr/local/bin',
}
</pre>

      <p><code>notify</code> and <code>subscribe</code> are two syntax options for creating the same type of relationship. Choose the option that makes the most sense to you. There is no difference in the compiled catalog between an <code>exec</code> that&#8217;s subscribed to a <code>file</code> and a <code>file</code> that notifies an <code>exec</code>.</p>

      <p>There are several other parameters that can be set on the exec resource, such as <code>cwd</code> to set the working directory for the command, and <code>user</code> to set the user to run the command. The details about all of the built in types can be found here: <a href="https://docs.puppet.com/references/latest/type.html">Puppet Docs - Type Reference</a>. If you&#8217;re managing Windows machines you should also look the the <a href="https://docs.puppet.com/puppet/latest/reference/resources_exec_windows.html">tips and examples for using Exec resources on Windows</a></p>

      <!-- End of primary test of the lesson -->
    </div>
    <h3 class="instruction-header">
      <strong><i class="fa fa-desktop"></i> Practice</strong>
    </h3>
    <div class="instruction-content">
      <!-- High level description of the exercise. -->
      <!-------------------------------------------->

      <p>Run <code>puppet agent -t</code> to load the example code on to your agent node.</p>

      <p>We&#8217;ve installed a few scripts to demonstrate different ways of using the exec resource. One is the <code>webuser</code> script mentioned in the lesson. Try out the examples above until you get the hang of it.</p>

      <p>There is also an example <code>.tar</code> file in /root. Create an exec resource to run <code>tar -xf</code> on that file and use the <code>creates</code> parameter to be sure it only happens once.</p>

      <p>Once you feel comfortable with exec resources, try opening the <code>/usr/bin/webuser</code> script to see if it can replaced with puppet code that doesn&#8217;t use the exec resource type.</p>

    </div>

    <h3 class="instruction-header">
      <strong><i class="fa fa-pencil"></i> Notes</strong>
    </h3>

  </div>
  <div id="terminal">
    <iframe id="try" name="terminal" src="https://try.puppet.com/sandbox/?course=exec"></iframe>
  </div>
</div>