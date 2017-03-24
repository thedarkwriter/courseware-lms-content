<!--
This is the template for the self-paced courses.
Put your content in between the comments that mark
out the different sections.  Text should be written
in markdown.
-->


<link rel="stylesheet" href="/static/selfpaced/selfpaced.css" />

<script defer="" src="//code.jquery.com/jquery-1.11.2.js"></script>

<script defer="" src="https://try.puppet.com/js/selfpaced.js"></script>

<div markdown="1" id="lesson">

<div markdown="1" id="instructions">

<div markdown="1" class="instruction-header">
<i class="fa fa-graduation-cap"></i>
Lesson
</div>
<div markdown="1" class="instruction-content">

<!-- Primary Text of the lesson -->
<!-------------------------------->

## Unit tests

Unit tests are short simple tests that form the first line of defense for your code. They are called unit tests because they are limited scope tests that focus on small units of code.

Since Puppet was originally written in Ruby, unit tests are generally written in a variation of `rspec` called `rspec-puppet` that can be installed as a gem on your development workstation. You should also install the `puppetlabs_spec_helper` gem, as it provides a lot of helpful features for developing puppet tests.

Rspec syntax reads almost like natural language, and once you're familiar with it you'll find it's easy to follow. For testing Puppet code, a good first step is to check that your code will compile.

For example, if you had a module to manage a webserver, you might have a class called `apache`. A minimal test for that class would be:

<pre>
<code>
describe 'apache', :type => 'class' do
  it { should compile }
end
</code>
</pre>

You can provide more human readable output when your tests run by using the `context` keyword.

For example, since we're just testing the `apache` class without parameters you could update the test to look like this:

<pre>
<code>
describe 'apache', :type => class do
  context "Default parameters" do
    if { should compile }
  end
end
</code>
</pre>

What if we want to test some of those parameters? It's pretty common to set the document root for a webserver to something other than the default, so let's assume the `apache` class has a `docroot` parameter. Use the `let` keyword to specify things like parameters in each context. Since we still want to keep the test for default parameters, we'll add a second context for the docroot parameter, like this:

<pre>
<code>
describe 'apache', :type => class do
  context "Default parameters" do
    it { should compile }
  end
  context "Docroot set to /var/www" do
    let(:params){
      :docroot => '/var/www'
    }
    it { should compile }
  end
end
</code>
</pre>

If we ran that last test, it would run through both contexts and let us know if one of them didn't compile. This might seem redundant since you're already written the Puppet code, but it can catch difficult to diagnose errors, especially once you move beyond just checking if the code compiles.

What if you'd actually named your parameter `doc_root` instead of `docroot`?

It's a simple mistake that would be easy to miss even in a thorough peer code review. Since `doc_root` and `docroot` are both valid syntax and style for parameters, `puppet parser validate` and `puppet-lint` wouldn't catch the mistake.

This is where unit tests really shine, once you've developed the habit of writing them alongside all of your code they'll offer a simple way to catch those errors before your code is even deployed to a testing environment. Although the syntax is correct, missing a required parameter or trying to set one that doesn't exist will cause a compilation error.

## Running Unit tests

If you're not familiar with ruby and rspec, running your tests can seem overwhelming. Thankfully, `puppetlabs_spec_helper` provides almost everything you'll need to actually run your tests.

You'll need to install the gem and create a few other files in your module.

First, create the `Rakefile` in the root directory of your module. The `Rakefile` provides a single starting point for your test scripts. Since the `puppetlabs_spec_helper` gem handles all of that, your `Rakefile` can be just two lines:

<pre>
<code>
require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'
</code>
</pre>

The next file to create is `spec/spec_helper.rb` which is also just two lines:
<pre>
<code>
require 'rubygems'
require 'puppetlabs_spec_helper/module_spec_helper'
</code>
</pre>

That file is where you can include helper methods and other details you'd like to include in your actual tests. The second `require` provides support for interacting with other modules.

The `.fixtures.yaml` file is in YAML format, which is a very human readable format for structured data. [yaml.org has the complete documentation](https://yaml.org) but the format is fairly intuitive. For the context of specifying `.fixtures.yaml` the format is fairly simple. If your module depends on the `chocolatey` module and the `stdlib` module, your `.fixtures.yaml` might look like this:

<pre>
<code>
fixtures:
  repositories:
    stdlib: "git://github.com/puppetlabs/puppetlabs-stdlib.git"
  forge_modules:
    chocolatey: "puppetlabs/chocolatey"
  symlinks:
    apache: "#{source_dir}"
</code>
</pre>

One quick trick for finding all of your modules dependencies is to run `puppet module install [your-modulename] --modulepath=/tmp/folder`

The Puppet module tool will resolve dependencies in your metadata.json, those modules dependencies, and so on. You can then get a list of all those modules using `puppet module list --modulepath=/tmp/folder`. Once you're done you can delete the folder.

Notice that we're using both a GitHub repository and a published Puppet forge module in that example. Depending on how you manage your code, you might need to specify different options. For the full syntax of `.fixtures.yml` look at the [puppetlabs_spec_helper documentation](https://github.com/puppetlabs/puppetlabs_spec_helper). For example, if you're working on an update that requires changes to two modules, you could temporarily specify that dependency as coming from your own fork and branch.

You should always use the simplest configuration that fits your needs, so it's generally best to keep fixtures pointed at published modules on the Puppet Forge.

Finally, you see that there is a section for `symlinks`, this is a way to tell `rspec-puppet` to use a local copy. In this case, it actually specifies the module we're testing. It sometimes makes sense to add more symlinks, but it's usually simpler to work with modules from the Puppet Forge or source control. 

Once you have all of your pieces in place you'll need to add a little to your actual test code. For the example we've been working with, this would be in a file called `spec/classes/apache_spec.rb`. Add the following line at the top before your tests:

<pre>
<code>
require 'spec_helper'
</code>
</pre>

That will pull in the code from `spec/spec_helper.rb`, which will deal with your fixture modules.

[This blog post](https://puppet.com/blog/next-generation-of-puppet-module-testing) provides more details of what you'll need to set up.

<!-- End of primary test of the lesson -->

</div>
<div markdown="1" class="instruction-header">
<i class="fa fa-desktop"></i>
Practice
</div>
<div markdown="1" class="instruction-content">

Take a look at the ssh module in `/root/puppetcode/modules`. The Puppet code has some problems. Start by running the tests to find out what's wrong and fix it.


</div>
</div>

<div markdown="1" id="terminal">
  <iframe id="try" src="https://try.puppet.com/sandbox/?course=testing" name="terminal"></iframe>
</div>
</div>

