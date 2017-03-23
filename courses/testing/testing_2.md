<!--
This is the template for the self-paced courses.
Put your content in between the comments that mark
out the different sections.  Text should be written
in markdown.
-->


<link rel="stylesheet" href="/static/selfpaced/selfpaced.css" />

<script defer="" src="//code.jquery.com/jquery-1.11.2.js"></script>

<script defer="" src="https://try.puppet.com/js/selfpaced.js"></script>

<div id="lesson">

<div id="instructions">

<div class="instruction-header">
<i class="fa fa-graduation-cap"></i>
Lesson
</div>
<div class="instruction-content">

<!-- Primary Text of the lesson -->
<!-------------------------------->

## Syntax and style validation

Validating code for syntax and style is a good place to start with testing your Puppet code. The most basic syntax test can be run anytime from the command line. Just type `puppet parser validate` and then the name of a file or directory to be checked. This can be a good habit as you're working on code to make sure you haven't made any obvious typos. Since it's easy to forget this step, git users will often add this as a pre-commit hook for any `.pp` file. A pre-commit hook will run before changes are committed to source control, so it's a quick way to catch obvious errors. Search online for examples of how to do this, or [take a look at the code we use in instructor led trainings](https://github.com/puppetlabs/pltraining-classroom/blob/master/files/pre-commit). You can also use this method to add syntax validation for frequently used file types such as `epp` and `yaml`. Git hooks are scripts that are run automatically at various points in your git workflow, [more information is available in the official git documentation](https://git-scm.com/docs/githooks).

To check your Puppet code style, [there is a gem called `puppet-lint`](http://puppet-lint.com/). Puppet-lint goes beyond correct syntax and warns if code doesn't follow the recommended style conventions. It will catch things like trailing whitespace or if `"` quotation marks are used instead of `'` in a string without variable interpolation. Some people choose to add puppet-lint to their pre-commit hooks along side `puppet parser validate` to help enforce good habits, but if you find it burdensome you can just run the command manually. If you'd rather not install the gem, you can use this [online Puppet code validator](https://validate.puppet.com/).

<!-- End of primary test of the lesson -->

</div>
<div class="instruction-header">
<i class="fa fa-desktop"></i>
Practice
</div>

<div class="instruction-content">

<!-- High level description of the exercise. -->
<!-------------------------------------------->

Try out some of these commands in the terminal to the right. First, run `puppet agent -t` to set up the example code. In the `/root` directory you'll find a file called `example.pp`. Using `puppet parser validate example.pp`, find and resolve the syntax errors in the code. If you'd like, install the `puppet-lint` gem with `gem install puppet-lint` and use it to find any style issues.

<!-- End of high level description. -->


</div>

<div class="instruction-header">
<i class="fa fa-pencil"></i>
Notes
</div>
<div class="instruction-content">

<!-- Other notes -->
<!-------------------->

In a later section, we'll look at how to incorporate these checks into your automated integration tests.


When you're ready to move on, just click to the next section, the practice
machine will shut down automatically when you're done.


<!-- End of notes section -->

</div>
</div>

<div id="terminal">
<iframe id="try" src="https://try.puppet.com/sandbox/?course=testing" name="terminal"></iframe>
</div>
</div>

