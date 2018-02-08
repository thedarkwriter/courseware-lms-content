<link rel="stylesheet" href="/static/selfpaced/selfpaced.css" />

<script src="https://code.jquery.com/jquery-1.11.2.js"></script>

<script src="https://try.puppet.com/js/selfpaced.js"></script>

<div id="lesson">
  <div id="instructions">
    <div class="instruction-header">
      <p><i class="fa fa-graduation-cap"></i>
Lesson</p>
    </div>
    <div class="instruction-content">
      <!-- Primary Text of the lesson -->
      <!-------------------------------->
      <p>For the purpose of using Puppet, you don&#8217;t need a deep understanding of the Linux command line. This course is intended as a basic introduction and refresher. If you would like a more comprehensive training, we recommend <a href="http://linuxjourney.com">Linux Journey</a>.</p>

      <p>Take a look at the window to the right. This is a Linux terminal running Bash.</p>

      <p>Notice a line similar to this:</p>
      <pre>
[root@yacolt-kenly /]#
</pre>

      <p>That&#8217;s your command prompt, we&#8217;ve customized it to add a couple of important pieces of information. The first part is your username, in this case <code>root</code> which is the Administrator account for the system. The second part is the name of the system, in this case <code>yacold-kenly</code>. Yours will be different, we randomly generate the system names for these courses from a list of international place names. The third part, in this case <code>/</code> is the current directory. <code>/</code> is the highest level directory in the file system, all other accesible directories are below it.</p>

      <p>Try out a few commands. <code>pwd</code> will tell you the current directory, <code>ls</code> will list the files in that directory.</p>
      <pre>
[root@yacolt-kenly /]# ls
anaconda-post.log  bin  boot  dev  etc  home  lib  lib64  lost+found  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
[root@yacolt-kenly /]# pwd
/
[root@yacolt-kenly /]#
</pre>

      <p>You can change directories with <code>cd</code>. Try changing to the <code>root</code> directory and listing the files:</p>
      <pre>
[root@yacolt-kenly /]# cd root/
[root@yacolt-kenly root]# ls
anaconda-ks.cfg  puppetcode
[root@yacolt-kenly root]#
</pre>

      <p>Notice the <code>puppetcode</code> directory? That isn&#8217;t commonly used in Puppet, but it&#8217;s something extra we&#8217;ve added for these courses. It&#8217;s a special directory we&#8217;ve connected to your code environment on the master. As you go through the other self-paced lessons, you&#8217;ll sometimes have to update code in that directory.</p>

      <p>The exercises also often require editing files. <code>vim</code> and <code>emacs</code> are the most popular Linux command line text editors, but neither one is very intuitive. To get started, you might want to use <code>nano</code> instead. Since different distributions of Linux have different commands for installing software, try a simple Puppet one-liner instead.</p>

      <pre>
[root@yacolt-kenly root]# puppet resource package nano ensure=present
Notice: /Package[nano]/ensure: created
package { 'nano':
  ensure =&gt; '2.3.1-10.el7',
}
[root@yacolt-kenly root]#
</pre>

      <p>Once it&#8217;s installed just type <code>nano</code> to run it. Type some text and press <code>Ctrl-x</code> to exit and follow the prompts at the bottom of the screen to save the file. You can also specify the file you&#8217;d like to edit when you run the nano command, like this: <code>nano /tmp/test.txt</code></p>

      <p>There is much more to learn about the command line, but this should be enough to get you through the online self-paced training.</p>

      <p>As you explore more, feel free to keep using the terminal provided here, or <a href="https://try.puppet.com/sandbox">open a full screen version</a>. This will work for most of the exercises on <a href="http://linuxjourney.com">Linux Journey</a>.</p>

      <!-- End of primary test of the lesson -->
    </div>
  </div>
  <div id="terminal">
    <iframe id="try" src="https://try.puppet.com/sandbox/?course=cli" name="terminal"></iframe>
  </div>
</div>