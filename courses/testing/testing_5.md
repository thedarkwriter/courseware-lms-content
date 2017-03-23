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

## Acceptance tests

The last level of testing before the code is actually deployed is acceptance tests. Acceptance tests go beyond just testing the compiled catalog and actually enforce the code being tested on a pre-production node or nodes. In our webserver example, this would mean running Puppet and then checking that a webserver is correctly installed and functioning. You might not realize it but you're probably already doing this kind of testing in some form, usually running code against a dev server or VM and manually checking the outcome.

At Puppet, we use an internally developed tool called Beaker for acceptance tests of Puppet itself and for testing supported modules. Beaker can be used for writing tests of your own modules, but since you've already written some rspec, we recommend using `beaker-rspec` which allows you to use rspec style and syntax for your Beaker tests. You can even incorporate [serverspec](http://serverspec.org/) tests when using `beaker-rspec`.

Acceptance tests are the most heavyweight; they require significant resources because they're testing the actual implementation of your Puppet code, not just the compilation. With that in mind, make sure you have adequate memory and CPU on your testing server. You'll also need to be able to run virtual machines on your testing server, for example using vagrant and virtualbox. Consider the resources currently allocated to your Puppet master node and any agent nodes you'd like to test in your acceptance tests and make sure you have adequate resources available to run equivalent virtual machines. This varies quite a bit, but a good starting place would be ~16GB of RAM and a Quad Core CPU.

To get started with acceptance tests, follow the instructions in [the README.md from the beaker-rspec github repository](https://github.com/puppetlabs/beaker-rspec/blob/master/README.md).

</div>

