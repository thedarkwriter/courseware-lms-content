<!--
This is the template for the self-paced courses.
Put your content in between the comments that mark
out the different sections.  Text should be written
in markdown.
-->

<link rel="stylesheet" href="/static/selfpaced/selfpaced.css" />

<script defer="" src="//code.jquery.com/jquery-1.11.2.js"></script>

<script defer="" src="https://try.puppet.com/js/selfpaced.js"></script>

<div id="instructions">
  <div class="instruction-header">
    <p><i class="fa fa-graduation-cap"></i>
Lesson</p>
  </div>
  <div class="instruction-content">

    <h2 id="acceptance-tests">Acceptance tests</h2>

    <p>The last level of testing before the code is actually deployed is acceptance tests. Acceptance tests go beyond just testing the compiled catalog and actually enforce the code being tested on a pre-production node or nodes.</p>

    <p>In our webserver example, this would mean running Puppet and then checking that a webserver is correctly installed and functioning. You might not realize it but you&#8217;re probably already doing this kind of testing in some form, usually running code against a dev server or VM and manually checking the outcome.</p>

    <p>At Puppet, we use an internally developed tool called Beaker for acceptance tests of Puppet itself and for testing supported modules.</p>

    <p>Beaker can be used for writing tests of your own modules, but since you&#8217;ve already written some rspec, we recommend using <code>beaker-rspec</code> which allows you to use rspec style and syntax for your Beaker tests. You can even incorporate <a href="http://serverspec.org/">serverspec</a> tests when using <code>beaker-rspec</code>.</p>

    <p>Acceptance tests are the most heavyweight; they require significant resources because they&#8217;re testing the actual implementation of your Puppet code, not just the compilation.</p>

    <p>With that in mind, make sure you have adequate memory and CPU on your testing server. You&#8217;ll also need to be able to run virtual machines on your testing server, for example using vagrant and virtualbox.</p>

    <p>Consider the resources currently allocated to your Puppet master node and any agent nodes you&#8217;d like to test in your acceptance tests and make sure you have adequate resources available to run equivalent virtual machines. This varies quite a bit, but a good starting place would be ~16GB of RAM and a Quad Core CPU.</p>

    <p>To get started with acceptance tests, follow the instructions in <a href="https://github.com/puppetlabs/beaker-rspec/blob/master/README.md">the README.md from the beaker-rspec github repository</a>.</p>

  </div>
</div>