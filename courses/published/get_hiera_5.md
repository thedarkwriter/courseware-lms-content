<link rel="stylesheet" href="/static/selfpaced/selfpaced.css" markdown="1">
<div id="lesson" markdown="1">

<div id="instructions" markdown="1">

<div class="instruction-header">
<i class="fa fa-graduation-cap"></i>
Lesson
</div>

<div class="instruction-content" markdown="1">

Now that we've seen what's possible with complex hierarchies, let's take a look
at some other ways of interacting with Hiera data. What if you want to combine
data from multiple levels of the hierarchy?

For example, you have a list of software packages that you want installed on
every server and some that depend on the environment. If you had to specify
that at every level of the hierarchy it would lead to a lot of duplicate data.

Thankfully, Hiera is more intelligent than that. Let's look at how this could
play out in a hierarchy with three levels. At the top, we have the per-node
configuration. Let's just set one up for Bob's dev server in
`nodes/bob.puppetlabs.vm.yaml`:
<pre>
---
package_list:
  - emacs
</pre>

All of the other developers use vim, so let's make sure the `development.yaml`
has that package along with some other useful things:
<pre>
---
package_list:
  - vim
  - gcc
  - cowsay
</pre>

But in production, we don't want anything extra, so instead of `vim` we'll just
have `vi` and leave out the other packages:
<pre>
---
package_list:
  - vi
</pre>

Finally, at the bottom of the hierarchy in `common.yaml`, we have a few packages
that should be installed on every machine in common.yaml:
<pre>
---
package_list:
  - dig
  - ssh
  - fortune
</pre>

Unfortunately, using the `hiera()` function will only return the result from a
single level in the hierarchy. To correctly merge across multiple levels of the
hierarchy, we'll use the `hiera_array()` function:

<pre>
$packages = hiera_array('package_list')
package { $packages:
  ensure => present,
}
</pre>

The best way to understand `hiera_array()` is to just dig in and try it out.
It's easy to test by using the command line `hiera` tool with the `-a`
argument. For example to see what packages are installed on Bob's dev
machine, you would use this command:
<pre>
hiera -a package_list environment=development certname=bob.puppetlabs.vm.yaml
</pre>

and the result would be:
<pre>
["fortune","dig","ssh","vim","gcc","cowsay","emacs"]
</pre> 

</div>
<div class="instruction-header">
<i class="fa fa-desktop"></i>
Practice
</div>
<div class="instruction-content" markdown="1">

We've set up these example files and a few more on the practice machine. Try a
few permutations until you have a feel for how `hiera_array()` works.

</div>


</div>

<div id="terminal">
  <iframe src="https://try.puppet.com/sandbox/?course=get_hiera5" name="terminal"></iframe>
</div>

</div>
