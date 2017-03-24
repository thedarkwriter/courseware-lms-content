
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

## Increasing coverage

Unit tests can test more than just compilation, you can write tests that will check that your code actually does what you think it does. In Puppet, there are two levels of thinking about this.

For unit tests, Puppet never actually applies the code. Instead it compiles the code and checks that the resources exist in the compiled catalog. 

For your webserver, you might write a test like this:

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
    it { should contain_package('apache').with_ensure('present') }
  end
end
</code>
</pre>

When that test is run, it compiles a Puppet catalog and checks that the "apache" package is in it. If you're new to unit testing, this probably still feels redundant since you've already written the Puppet code to do this.

The important piece here is that your unit tests treat the Puppet code as a black box. As code becomes more complex with multiple parameters and conditional statements, it can be easy to make a logic error that will be hard to track down if you're not testing for each supported configuration.

Take this example Puppet code:

<pre>
<code>
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
</code>
</pre>

Different operating systems sometimes need different package names or providers and if you want your module to be flexible you need a good way to test each operating system. The unit tests for this bit of code would try each of those values.

Since `$osfamily` is a fact instead of a parameter, we'll use `let(:facts){}` to set it for each test.

<pre>
<code>
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
</code>
</pre>

Adding coverage is important, but remember to be realistic. There is little sense in covering testing scenarios that will never happen in real life.

It also isn't generally necessary to have 100% coverage for your tests. 80% coverage, focusing on those pieces most likely to fail is usually sufficient. The other 20% of time is better spent on higher level testing or increasing coverage in other modules. That said, it's often worth adding a few unit tests for unsupported configurations to makes sure that your module also fails gracefully and provides informative error messages.

## Integration tests

Unit tests are made to test small units of code, integration tests focus on bringing those units together.

In Puppet, the line between unit tests and integration tests is a bit blurry. It's better to think of integration tests and unit tests as two ends of a spectrum, with integration tests focusing on the most complex behavior you expect from your module.

To get started with integration testing, think of example usage code that you would include in the README of your module or the example usage you've put in the examples directory. If you're regularly using the module in one particular way, be sure to include at least that configuration in your integration tests. 

You don't need to cover every possible use for your module, just focus your attention on common ones. If you're using resource types from other modules, that usage should be covered by your integration tests.

## Test driven development

You might be thinking that the syntax of those tests reads a bit like a specification of how the code should work. For example, you might specify that code by writing "An apache module that will install the apache package on RedHat and the httpd package on Debian. It should also let you specify an alternate document root." etc.

One very powerful approach is to actually write the tests before writing any code at all. This is known as `Test Driven Development`.

Test driven development can help focus on the basic requirements before adding new features, it's also a great way to enforce the habit of testing all your code. If you're working in a team setting, one useful strategy is for different team members to write the tests and code.

For those who enjoy solving problems, test driven develop can also add an element of fun. Once the test is written, think of the module as being "broken" and your task becomes fixing it. It sounds silly, but it is a really helpful way of reframing your work.

<!-- End of primary test of the lesson -->

</div>
<div markdown="1" class="instruction-header">
<i class="fa fa-desktop"></i>
Practice
</div>

<div markdown="1" class="instruction-content">

<!-- High level description of the exercise. -->
<!-------------------------------------------->

## Exercises

We've provided a module with a few fully written tests and a few that only have comments describing the specification. None of the Puppet code is written yet. Take a look at the tests and write some Puppet code to make them pass.


<!-- End of high level description. -->


</div>

</div>

<div markdown="1" id="terminal">
<iframe id="try" src="https://try.puppet.com/sandbox/?course=testing" name="terminal"></iframe>
</div>
</div>
