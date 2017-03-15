## Testing

Automated testing is an essential part of creating solid, reliable Puppet code. Developing tests for Puppet code does not need to be a burden, but it can be difficult to know where to start. In this course, you'll learn about the different kinds of tests, the basics of testing Puppet code, how you can get started with testing, and how testing can enable you to move faster in development with less risk.

## Kinds of tests

Imagine your tests like a series of sieves or filters trying to filter rocks and debris out of a pile of rocky soil. You'd want to start with a cheap sturdy filter to first remove the larges boulders. Below that, you'd have a finer screen to catch medium sized rocks and branches. After several layers you might have a very delicate fine mesh that would only let the good soil through. It might seem like a good idea to just have that final filter, after all it would catch boulders as well as pebbles, but that final stage is also the most expensive, the most delicate, and the slowest. It's best to be close to the finished product when you get to that stage.

With testing Puppet code, you can very quickly catch a large number of bugs with minimal effort. With each layer of testing you'll focus on finer details. Since you've already caught the larger bugs, you don't need to cover such a large area, which is good because the tests become more complicated and slower with each level.

There are few different categories of tests that are relevant to Puppet:

* Syntax and style validation
* Unit tests
* Integration tests
* Acceptance tests

## Syntax and style validation

Validating code for syntax and style is a good place to start with testing your Puppet code. The most basic syntax test can be run anytime from the command line. Just type `puppet parser validate` and then the name of a file or directory to be checked. This can be a good habit as you're working on code to make sure you haven't made any obvious typos. Since it's easy to forget this step, git users will often add this as a pre-commit hook for any `.pp` file. A pre-commit hook will run before changes are committed to source control, so it's a quick way to catch obvious errors. Search online for examples of how to do this, or [take a look at the code we use in instructor led trainings](https://github.com/puppetlabs/pltraining-classroom/blob/master/files/pre-commit). You can also use this method to add syntax validation for frequently used file types such as `epp` and `yaml`. Git hooks are scripts that are run automatically at various points in your git workflow, [more information is available in the official git documentation](https://git-scm.com/docs/githooks).

To check your Puppet code style, [there is a gem called `puppet-lint`](http://puppet-lint.com/). Puppet-lint goes beyond correct syntax and warns if code doesn't follow the recommended style conventions. It will catch things like trailing whitespace or if `"` quotation marks are used instead of `'` in a string without variable interpolation. Some people choose to add puppet-lint to their pre-commit hooks along side `puppet parser validate` to help enforce good habits, but if you find it burdensome you can just run the command manually. If you'd rather not install the gem, you can use this [online Puppet code validator](https://validate.puppet.com/).

## Practice

Try out some of these commands in the terminal to the right. First, run `puppet agent -t` to set up the example code. In the `/root` directory you'll find a file called `example.pp`. Using `puppet parser validate example.pp`, find and resolve the syntax errors in the code. If you'd like, install the `puppet-lint` gem with `gem install puppet-lint` and use it to find any style issues.

## Notes

In a later section, we'll look at how to incorporate these checks into your automated integration tests.

## Unit tests

Unit tests are short simple tests that form the first line of defense for your code. They are called unit tests because they are limited scope tests that focus on small units of code. Since Puppet was originally written in Ruby, unit tests are generally written in a variation of `rspec` called `rspec-puppet` that can be installed as a gem on your development workstation. You should also install the `puppetlabs_spec_helper` gem, as it provides a lot of helpful features for developing puppet tests.

Rspec syntax reads almost like natural language, and once you're familiar with it you'll find it's easy to follow. For testing Puppet code, a good first step is to check that your code will compile.

For example, if you had a module to manage a webserver, you might have a class called `apache`. A minimal test for that class would be:

<pre>
describe 'apache', :type => 'class' do
  it { should compile }
end
</pre>

You can provide more human readable output when your tests run by using the `context` keyword.

For example, since we're just testing the `apache` class without parameters you could update the test to look like this:

<pre>
describe 'apache', :type => class do
  context "Default parameters" do
    if { should compile }
  end
end
</pre>

What if we want to test some of those parameters? It's pretty common to set the document root for a webserver to something other than the default, so let's assume the `apache` class has a `docroot` parameter. Use the `let` keyword to specify things like parameters in each context. Since we still want to keep the test for default parameters, we'll add a second context for the docroot parameter, like this:

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

If we ran that last test, it would run through both contexts and let us know if one of them didn't compile. This might seem redundant since you're already written the Puppet code, but it can catch difficult to diagnose errors, especially once you move beyond just checking if the code compiles.

What if you'd actually named your parameter `doc_root` instead of `docroot`? It's a simple mistake that would be easy to miss even in a thorough peer code review. Since `doc_root` and `docroot` are both valid syntax and style for parameters, `puppet parser validate` and `puppet-lint` wouldn't catch the mistake. This is where unit tests really shine, once you've developed the habit of writing them alongside all of your code they'll offer a simple way to catch those errors before your code is even deployed to a testing environment. Although the syntax is correct, missing a required parameter or trying to set one that doesn't exist will cause a compilation error.

## Running Unit tests

If you're not familiar with ruby and rspec, running your tests can seem overwhelming. Thankfully, `puppetlabs_spec_helper` provides almost everything you'll need to actually run your tests.

You'll need to install the gem and create a few other files in your module.

First, create the `Rakefile` in the root directory of your module. The `Rakefile` provides a single starting point for your test scripts. Since the `puppetlabs_spec_helper` gem handles all of that, your `Rakefile` can be just two lines:

<pre>
require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'
</pre>

The next file to create is `spec/spec_helper.rb` which is also just two lines:
<pre>
require 'rubygems'
require 'puppetlabs_spec_helper/module_spec_helper'
</pre>

That file is where you can include helper methods and other details you'd like to include in your actual tests. The second `require` provides support for interacting with other modules.

The `.fixtures.yaml` file is in YAML format, which is a very human readable format for structured data. [yaml.org has the complete documentation](https://yaml.org) but the format is fairly intuitive. For the context of specifying `.fixtures.yaml` the format is fairly simple. If your module depends on the `chocolatey` module and the `stdlib` module, your `.fixtures.yaml` might look like this:

<pre>
fixtures:
  repositories:
    stdlib: "git://github.com/puppetlabs/puppetlabs-stdlib.git"
  forge_modules:
    chocolatey: "puppetlabs/chocolatey"
  symlinks:
    apache: "#{source_dir}"
</pre>

One quick trick for finding all of your modules dependencies is to run `puppet module install <your-modulename> --modulepath=/tmp/folder` The Puppet module tool will resolve dependencies in your metadata.json, those modules dependencies, and so on. You can then get a list of all those modules using `puppet module list --modulepath=/tmp/folder`. Once you're done you can delete the folder.

Notice that we're using both a GitHub repository and a published Puppet forge module in that example. Depending on how you manage your code, you might need to specify different options. For the full syntax of `.fixtures.yml` look at the [puppetlabs_spec_helper documentation](https://github.com/puppetlabs/puppetlabs_spec_helper). For example, if you're working on an update that requires changes to two modules, you could temporarily specify that dependency as coming from your own fork and branch. You should always use the simplest configuration that fits your needs, so it's generally best to keep fixtures pointed at published modules on the Puppet Forge.

Finally, you see that there is a section for `symlinks`, this is a way to tell `rspec-puppet` to use a local copy. In this case, it actually specifies the module we're testing. It sometimes makes sense to add more symlinks, but it's usually simpler to work with modules from the Puppet Forge or source control. 

Once you have all of your pieces in place you'll need to add a little to your actual test code. For the example we've been working with, this would be in a file called `spec/classes/apache_spec.rb`. Add the following line at the top before your tests:
<code>
require 'spec_helper'
</code>

That will pull in the code from `spec/spec_helper.rb`, which will deal with your fixture modules.

[This blog post](https://puppet.com/blog/next-generation-of-puppet-module-testing) provides more details of what you'll need to set up.

## Practice

Take a look at the ssh module in `/root/puppetcode/modules`. The Puppet code has some problems. Start by running the tests to find out what's wrong and fix it.

## Increasing coverage

Unit tests can test more than just compilation, you can write tests that will check that your code actually does what you think it does. In Puppet, there are two levels of thinking about this. For unit tests, Puppet never actually applies the code. Instead it compiles the code and checks that the resources exist in the compiled catalog. For your webserver, you might write a test like this:

<pre>
describe 'apache', :type => class do
  context "Default parameters" do
    it { should compile }
  end
  context "Docroot set to /var/www" do
    let(:params){
      :docroot => '/var/www'
    }
    it { should compile }
    it { should contain_package('apache').with_ensure('present') }
  end
end
</pre>

When that test is run, it compiles a Puppet catalog and checks that the "apache" package is in it. If you're new to unit testing, this probably still feels redundant since you've already written the Puppet code to do this. The important piece here is that your unit tests treat the Puppet code as a black box. As code becomes more complex with multiple parameters and conditional statements, it can be easy to make a logic error that will be hard to track down if you're not testing for each supported configuration.

Take this example Puppet code:

<pre>
case $osfamily {
  'redhat': {
    package {'apache':
      ensure => present,
    }
  }
  'debian': {
    package {'httpd':
      ensure => present,
    }
  }
  'windows': {
    package {'apache':
      ensure => present,
      provider => 'chocolatey',
    }  
  }
  default: {
    fail("Unsupported operating system ${osfamily}")
  }
}
</pre>

Different operating systems sometimes need different package names or providers and if you want your module to be flexible you need a good way to test each operating system. The unit tests for this bit of code would try each of those values. Since `$osfamily` is a fact instead of a parameter, we'll use `let(:facts){}` to set it for each test.

<pre>
describe 'apache', :type => class do
  context "RedHat OS" do
    let(:facts){
      :osfamily => 'redhat'
    }
    it { should compile }
    it { should contain_package('apache').with_ensure('present') }
  end
  context "Debian OS" do
    let(:facts){
      :osfamily => 'debian'
    }
    it { should compile }
    it { should contain_package('httpd').with_ensure('present') }
  end
  ...
end
</pre>

Adding coverage is important, but remember to be realistic. There is little sense in covering testing scenarios that will never happen in real life. It also isn't generally necessary to have 100% coverage for your tests. 80% coverage, focusing on those pieces most likely to fail is usually sufficient. The other 20% of time is better spent on higher level testing or increasing coverage in other modules. That said, it's often worth adding a few unit tests for unsupported configurations to makes sure that your module also fails gracefully and provides informative error messages.

## Integration tests

Unit tests are made to test small units of code, integration tests focus on bringing those units together. In Puppet the line between unit tests and integration tests is a bit blurry. It's better to think of integration tests and unit tests as two ends of a spectrum, with integration tests focusing on the most complex behavior you expect from your module. To get started with integration testing, think of example usage code that you would include in the README of your module or the example usage you've put in the examples directory. If you're regularly using the module in one particular way, be sure to include at least that configuration in your integration tests. You don't need to cover every possible use for your module, just focus your attention on common ones. If you're using resource types from other modules, that usage should be covered by your integration tests.

## Test driven development

You might be thinking that the syntax of those tests reads a bit like a specification of how the code should work. For example, you might specify that code by writing "An apache module that will install the apache package on RedHat and the httpd package on Debian. It should also let you specify an alternate document root." etc. One very powerful approach is to actually write the tests before writing any code at all. This is known as `Test Driven Development`.

Test driven development can help focus on the basic requirements before adding new features, it's also a great way to enforce the habit of testing all your code. If you're working in a team setting, one useful strategy is for different team members to write the tests and code.

For those who enjoy solving problems, test driven develop can also add an element of fun. Once the test is written, think of the module as being "broken" and your task becomes fixing it. It sounds silly, but it is a really helpful way of reframing your work.

## Exercises

We've provided a module with a few fully written tests and a few that only have comments describing the specification. None of the Puppet code is written yet. Take a look at the tests and write some Puppet code to make them pass.

## Acceptance tests

The last level of testing before the code is actually deployed is acceptance tests. Acceptance tests go beyond just testing the compiled catalog and actually enforce the code being tested on a pre-production node or nodes. In our webserver example, this would mean running Puppet and then checking that a webserver is correctly installed and functioning. You might not realize it but you're probably already doing this kind of testing in some form, usually running code against a dev server or VM and manually checking the outcome.

At Puppet, we use an internally developed tool called Beaker for acceptance tests of Puppet itself and for testing supported modules. Beaker can be used for writing tests of your own modules, but since you've already written some rspec, we recommend using `beaker-rspec` which allows you to use rspec style and syntax for your Beaker tests. You can even incorporate [serverspec](http://serverspec.org/) tests when using `beaker-rspec`.

Acceptance tests are the most heavyweight; they require significant resources because they're testing the actual implementation of your Puppet code, not just the compilation. With that in mind, make sure you have adequate memory and CPU on your testing server. You'll also need to be able to run virtual machines on your testing server, for example using vagrant and virtualbox. Consider the resources currently allocated to your Puppet master node and any agent nodes you'd like to test in your acceptance tests and make sure you have adequate resources available to run equivalent virtual machines. This varies quite a bit, but a good starting place would be ~16GB of RAM and a Quad Core CPU.

To get started with acceptance tests, follow the instructions in [the README.md from the beaker-rspec github repository](https://github.com/puppetlabs/beaker-rspec/blob/master/README.md).


## Conclusion

A comprehensive suite of tests for your Puppet code can offer tremendous peace of mind and free up your team to move more quickly. As your code base becomes more complex, tests become even more important. Although tests take time to write, investing that time now will pay off in a fewer emergencies in the future.

## References

The supported and approved Puppet Forge modules are a great place to look for example code. The `puppetlabs-apache` module has [an extensive set of acceptance tests](https://github.com/puppetlabs/puppetlabs-apache/tree/master/spec/acceptance).
