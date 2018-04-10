As you've been working on your code in previous sections, you've written a lot of repetitive words, such as the names of packages or filenames. As you just learned, variables are a useful construct for storing a value once and then reusing it multiple times elsewhere in your code.

Let's take some of the code you've already written and introduce variables into it. Using variables reduces repetition and the chance of making mistakes by misspelling something.

> **Pro Tip:**

> You can use comments in your code by using a hash like this: `# this is what a comment looks like`. Comments help you describe the function of your code and to communicate it to other people who read your code.

**Example:**

<pre>
# $service_name is a variable that holds the name of the service
# so it can be used in multiple places without repeatedly typing
# the value.
$service_name = 'robby'

file { '/etc/robby/robby.cfg':
  ensure  => file,
  notify  => Service[$service_name],
}

service { $service_name:
  ensure => running,
  enable => true,
}
</pre>

## Task:

Currently, the code you have been working on in this course has hard-coded package names in it. As you learned, using variables rather than hard-coding information about your file is a better method to write code because it reduces the likelihood of typos and bugs. Try using a variable instead.

Set the `$package_name` variable to `robby`.

<iframe src="https://magicbox.classroom.puppet.com/scenario/putting_variables_to_use" width="100%" height="550px" frameborder="0"></iframe>
