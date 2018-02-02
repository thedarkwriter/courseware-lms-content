<link rel="stylesheet" href="/static/selfpaced/selfpaced.css" />

<script defer="[]" src="//code.jquery.com/jquery-1.11.2.js" />

<script defer="[]" src="https://try.puppet.com/js/selfpaced.js" />

<div id="lesson">

  <div id="instructions">

    <div class="instruction-header">
      <p><i class="fa fa-graduation-cap" />
Lesson</p>
    </div>
    <div class="instruction-content">

      <h2 id="unit-tests">Unit tests</h2>

      <p>Unit tests are short simple tests that form the first line of defense for your code. They are called unit tests because they are limited scope tests that focus on small units of code.</p>

      <p>Since Puppet was originally written in Ruby, unit tests are generally written in a variation of <code>rspec</code> called <code>rspec-puppet</code> that can be installed as a gem on your development workstation. You should also install the <code>puppetlabs_spec_helper</code> gem, as it provides a lot of helpful features for developing puppet tests.</p>

      <p>Rspec syntax reads almost like natural language, and once you&#8217;re familiar with it you&#8217;ll find it&#8217;s easy to follow. For testing Puppet code, a good first step is to check that your code will compile.</p>

      <p>For example, if you had a module to manage a webserver, you might have a class called <code>apache</code>. A minimal test for that class would be:</p>

      <pre>
<code>
describe 'apache', :type =&gt; 'class' do
  it { should compile }
end
</code>
</pre>

      <p>You can provide more human readable output when your tests run by using the <code>context</code> keyword.</p>

      <p>For example, since we&#8217;re just testing the <code>apache</code> class without parameters you could update the test to look like this:</p>

      <pre>
<code>
describe 'apache', :type =&gt; class do
  context "Default parameters" do
    if { should compile }
  end
end
</code>
</pre>

      <p>What if we want to test some of those parameters? It&#8217;s pretty common to set the document root for a webserver to something other than the default, so let&#8217;s assume the <code>apache</code> class has a <code>docroot</code> parameter. Use the <code>let</code> keyword to specify things like parameters in each context. Since we still want to keep the test for default parameters, we&#8217;ll add a second context for the docroot parameter, like this:</p>

      <pre>
<code>
describe 'apache', :type =&gt; class do
  context "Default parameters" do
    it { should compile }
  end
  context "Docroot set to /var/www" do
    let(:params){
      :docroot =&gt; '/var/www'
    }
    it { should compile }
  end
end
</code>
</pre>

      <p>If we ran that last test, it would run through both contexts and let us know if one of them didn&#8217;t compile. This might seem redundant since you&#8217;re already written the Puppet code, but it can catch difficult to diagnose errors, especially once you move beyond just checking if the code compiles.</p>

      <p>What if you&#8217;d actually named your parameter <code>doc_root</code> instead of <code>docroot</code>?</p>

      <p>It&#8217;s a simple mistake that would be easy to miss even in a thorough peer code review. Since <code>doc_root</code> and <code>docroot</code> are both valid syntax and style for parameters, <code>puppet parser validate</code> and <code>puppet-lint</code> wouldn&#8217;t catch the mistake.</p>

      <p>This is where unit tests really shine, once you&#8217;ve developed the habit of writing them alongside all of your code they&#8217;ll offer a simple way to catch those errors before your code is even deployed to a testing environment. Although the syntax is correct, missing a required parameter or trying to set one that doesn&#8217;t exist will cause a compilation error.</p>

      <h2 id="running-unit-tests">Running Unit tests</h2>

      <p>If you&#8217;re not familiar with ruby and rspec, running your tests can seem overwhelming. Thankfully, <code>puppetlabs_spec_helper</code> provides almost everything you&#8217;ll need to actually run your tests.</p>

      <p>You&#8217;ll need to install the gem and create a few other files in your module.</p>

      <p>First, create the <code>Rakefile</code> in the root directory of your module. The <code>Rakefile</code> provides a single starting point for your test scripts. Since the <code>puppetlabs_spec_helper</code> gem handles all of that, your <code>Rakefile</code> can be just two lines:</p>

      <pre>
<code>
require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'
</code>
</pre>

      <p>The next file to create is <code>spec/spec_helper.rb</code> which is also just two lines:</p>
      <pre>
<code>
require 'rubygems'
require 'puppetlabs_spec_helper/module_spec_helper'
</code>
</pre>

      <p>That file is where you can include helper methods and other details you&#8217;d like to include in your actual tests. The second <code>require</code> provides support for interacting with other modules.</p>

      <p>The <code>.fixtures.yaml</code> file is in YAML format, which is a very human readable format for structured data. <a href="https://yaml.org">yaml.org has the complete documentation</a> but the format is fairly intuitive. For the context of specifying <code>.fixtures.yaml</code> the format is fairly simple. If your module depends on the <code>chocolatey</code> module and the <code>stdlib</code> module, your <code>.fixtures.yaml</code> might look like this:</p>

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

      <p>One quick trick for finding all of your modules dependencies is to run</p>
      <pre>
<code>
puppet module install [your-modulename] --modulepath=/tmp/folder
</code>
</pre>

      <p>The Puppet module tool will resolve dependencies in your metadata.json, those modules dependencies, and so on. You can then get a list of all those modules using</p>

      <pre>
<code>
puppet module list --modulepath=/tmp/folder
</code>
</pre>

      <p>Once you&#8217;re done you can delete the folder.</p>

      <p>Notice that we&#8217;re using both a GitHub repository and a published Puppet forge module in that example. Depending on how you manage your code, you might need to specify different options. For the full syntax of <code>.fixtures.yml</code> look at the <a href="https://github.com/puppetlabs/puppetlabs_spec_helper">puppetlabs_spec_helper documentation</a>. For example, if you&#8217;re working on an update that requires changes to two modules, you could temporarily specify that dependency as coming from your own fork and branch.</p>

      <p>You should always use the simplest configuration that fits your needs, so it&#8217;s generally best to keep fixtures pointed at published modules on the Puppet Forge.</p>

      <p>Finally, you see that there is a section for <code>symlinks</code>, this is a way to tell <code>rspec-puppet</code> to use a local copy. In this case, it actually specifies the module we&#8217;re testing. It sometimes makes sense to add more symlinks, but it&#8217;s usually simpler to work with modules from the Puppet Forge or source control.</p>

      <p>Once you have all of your pieces in place you&#8217;ll need to add a little to your actual test code. For the example we&#8217;ve been working with, this would be in a file called <code>spec/classes/apache_spec.rb</code>. Add the following line at the top before your tests:</p>

      <pre>
<code>
require 'spec_helper'
</code>
</pre>

      <p>That will pull in the code from <code>spec/spec_helper.rb</code>, which will deal with your fixture modules.</p>

      <p><a href="https://puppet.com/blog/next-generation-of-puppet-module-testing">This blog post</a> provides more details of what you&#8217;ll need to set up.</p>

    </div>
    <div class="instruction-header">
      <p><i class="fa fa-desktop" />
Practice</p>
    </div>
    <div class="instruction-content">

      <p>Take a look at the ssh module in <code>/root/puppetcode/modules</code>. The Puppet code has some problems. Start by running the tests to find out what&#8217;s wrong and fix it.</p>

    </div>
  </div>

  <div id="terminal">
    <iframe id="try" src="https://try.puppet.com/sandbox/?course=testing" name="terminal" />
  </div>
</div>