<link rel="stylesheet" href="/static/selfpaced/selfpaced.css" />

<script defer="" src="//code.jquery.com/jquery-1.11.2.js"></script>

<script defer="" src="https://try.puppet.com/js/selfpaced.js"></script>

<div id="lesson">

  <div id="instructions">

    <div class="instruction-header">
      <p><i class="fa fa-graduation-cap"></i>
Lesson</p>
    </div>
    <div class="instruction-content">

      <!-- Primary Text of the lesson -->
      <!-------------------------------->

      <h2 id="syntax-and-style-validation">Syntax and style validation</h2>

      <p>Validating code for syntax and style is a good place to start with testing your Puppet code.</p>

      <p>The most basic syntax test can be run anytime from the command line. Just type <code>puppet parser validate</code> and then the name of a file or directory to be checked.</p>

      <p>This can be a good habit as you&#8217;re working on code to make sure you haven&#8217;t made any obvious typos.</p>

      <p>Since it&#8217;s easy to forget this step, git users will often add this as a pre-commit hook for any <code>.pp</code> file. A pre-commit hook will run before changes are committed to source control, so it&#8217;s a quick way to catch obvious errors. Search online for examples of how to do this, or <a href="https://github.com/puppetlabs/pltraining-classroom/blob/master/files/pre-commit">take a look at the code we use in instructor led trainings</a>.</p>

      <p>You can also use this method to add syntax validation for frequently used file types such as <code>epp</code> and <code>yaml</code>. Git hooks are scripts that are run automatically at various points in your git workflow, <a href="https://git-scm.com/docs/githooks">more information is available in the official git documentation</a>.</p>

      <p>To check your Puppet code style, <a href="http://puppet-lint.com/">there is a gem called <code>puppet-lint</code></a>. Puppet-lint goes beyond correct syntax and warns if code doesn&#8217;t follow the recommended style conventions. It will catch things like trailing whitespace or if <code>"</code> quotation marks are used instead of <code>'</code> in a string without variable interpolation.</p>

      <p>Some people choose to add puppet-lint to their pre-commit hooks along side <code>puppet parser validate</code> to help enforce good habits, but if you find it burdensome you can just run the command manually. If you&#8217;d rather not install the gem, you can use this <a href="https://validate.puppet.com/">online Puppet code validator</a>.</p>

      <!-- End of primary test of the lesson -->

    </div>
    <div class="instruction-header">
      <p><i class="fa fa-desktop"></i>
Practice</p>
    </div>

    <div class="instruction-content">

      <!-- High level description of the exercise. -->
      <!-------------------------------------------->

      <p>Try out some of these commands in the terminal to the right. First, run <code>puppet agent -t</code> to set up the example code. In the <code>/root</code> directory you&#8217;ll find a file called <code>example.pp</code>. Using <code>puppet parser validate example.pp</code>, find and resolve the syntax errors in the code. If you&#8217;d like, install the <code>puppet-lint</code> gem with <code>gem install puppet-lint</code> and use it to find any style issues.</p>

      <!-- End of high level description. -->

    </div>

    <div class="instruction-header">
      <p><i class="fa fa-pencil"></i>
Notes</p>
    </div>
    <div class="instruction-content">

      <!-- Other notes -->
      <!-------------------->

      <p>In a later section, we&#8217;ll look at how to incorporate these checks into your automated integration tests.</p>

      <p>When you&#8217;re ready to move on, just click to the next section, the practice
machine will shut down automatically when you&#8217;re done.</p>

      <!-- End of notes section -->

    </div>
  </div>

  <div id="terminal">
    <iframe id="try" src="https://try.puppet.com/sandbox/?course=testing" name="terminal"></iframe>
  </div>
</div>