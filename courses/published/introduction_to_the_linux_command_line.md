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
For the purpose of using Puppet, you don't need a deep understanding of the Linux command line. This course is intended as a basic introduction and refresher. If you would like a more comprehensive training, we recommend [Linux Journey](http://linuxjourney.com).

Take a look at the window to the right. This is a Linux terminal running Bash.

Notice a line similar to this:
<pre>
[root@yacolt-kenly /]#
</pre>

That's your command prompt, we've customized it to add a couple of important pieces of information. The first part is your username, in this case `root` which is the Administrator account for the system. The second part is the name of the system, in this case `yacold-kenly`. Yours will be different, we randomly generate the system names for these courses from a list of international place names. The third part, in this case `/` is the current directory. `/` is the highest level directory in the file system, all other accesible directies are below it.

Try out a few commands. `pwd` will tell you the current directory, `ls` will list the files in that directory.
<pre>
[root@yacolt-kenly /]# ls
anaconda-post.log  bin  boot  dev  etc  home  lib  lib64  lost+found  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
[root@yacolt-kenly /]# pwd
/
[root@yacolt-kenly /]#
</pre>

You can change directories with `cd`. Try changing to the `root` directory and listing the files:
<pre>
[root@yacolt-kenly /]# cd root/
[root@yacolt-kenly root]# ls
anaconda-ks.cfg  puppetcode
[root@yacolt-kenly root]#
</pre>

Notice the `puppetcode` directory? That isn't commonly used in Puppet, but it's something extra we've added for these courses. It's a special directory we've connected to your code environment on the master. As you go through the other self-paced lessons, you'll sometimes have to update code in that directory.

The exercises also often require editing files. `vim` and `emacs` are the most popular Linux command line text editors, but neither one is very intuitive. To get started, you might want to use `nano` instead. Since different distributions of Linux have different commands for installing software, try a simple Puppet one-liner instead.

<pre>
[root@yacolt-kenly root]# puppet resource package nano ensure=present
Notice: /Package[nano]/ensure: created
package { 'nano':
  ensure => '2.3.1-10.el7',
}
[root@yacolt-kenly root]#
</pre>

Once it's installed just type `nano` to run it. Type some text and press `Ctrl-x` to exit and follow the prompts at the bottom of the screen to save the file. You can also specify the file you'd like to edit when you run the nano command, like this: `nano /tmp/test.txt`

There is much more to learn about the command line, but this should be enough to get you through the online self-paced training.

As you explore more, feel free to keep using the terminal provided here, or [open a full screen version](https://try.puppet.com/sandbox). This will work for most of the exercises on [Linux Journey](http://linuxjourney.com).

<!-- End of primary test of the lesson -->
</div>
<div id="terminal" markdown="1">
  <iframe name="terminal"></iframe>
</div>
</div>
