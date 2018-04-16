<script defer="" src="//code.jquery.com/jquery-1.11.2.js"></script>

<script defer="" src="https://try.puppet.com/js/selfpaced.js"></script>

<div id="lesson">

  <div id="instructions">

    <h3 class="instruction-header">
      <strong><i class="fa fa-graduation-cap"></i> Lesson</strong>
    </h3>
    <div class="instruction-content">

      <!-- Primary Text of the lesson -->
      <!-------------------------------->

      <h3 id="increasing-coverage">Increasing coverage</h3>

      <p>Unit tests can test more than just compilation, you can write tests that will check that your code actually does what you think it does. In Puppet, there are two levels of thinking about this.</p>

      <p>For unit tests, Puppet never actually applies the code. Instead it compiles the code and checks that the resources exist in the compiled catalog.</p>

      <p>For your webserver, you might write a test like this:</p>

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
    it { should contain_package('apache').with_ensure('present') }
  end
end
</code>
</pre>

      <p>When that test is run, it compiles a Puppet catalog and checks that the &#8220;apache&#8221; package is in it. If you&#8217;re new to unit testing, this probably still feels redundant since you&#8217;ve already written the Puppet code to do this.</p>

      <p>The important piece here is that your unit tests treat the Puppet code as a black box. As code becomes more complex with multiple parameters and conditional statements, it can be easy to make a logic error that will be hard to track down if you&#8217;re not testing for each supported configuration.</p>

      <p>Take this example Puppet code:</p>

      <pre>
<code>
case $osfamily {
  'redhat': {
    package {'apache':
      ensure =&gt; present,
    }
  }
  'debian': {
    package {'httpd':
      ensure =&gt; present,
    }
  }
  'windows': {
    package {'apache':
      ensure =&gt; present,
      provider =&gt; 'chocolatey',
    }  
  }
  default: {
    fail("Unsupported operating system ${osfamily}")
  }
}
</code>
</pre>

      <p>Different operating systems sometimes need different package names or providers and if you want your module to be flexible you need a good way to test each operating system. The unit tests for this bit of code would try each of those values.</p>

      <p>Since <code>$osfamily</code> is a fact instead of a parameter, we&#8217;ll use <code>let(:facts){}</code> to set it for each test.</p>

      <pre>
<code>
describe 'apache', :type =&gt; class do
  context "RedHat OS" do
    let(:facts){
      :osfamily =&gt; 'redhat'
    }
    it { should compile }
    it { should contain_package('apache').with_ensure('present') }
  end
  context "Debian OS" do
    let(:facts){
      :osfamily =&gt; 'debian'
    }
    it { should compile }
    it { should contain_package('httpd').with_ensure('present') }
  end
  ...
end
</code>
</pre>

      <p>Adding coverage is important, but remember to be realistic. There is little sense in covering testing scenarios that will never happen in real life.</p>

      <p>It also isn&#8217;t generally necessary to have 100% coverage for your tests. 80% coverage, focusing on those pieces most likely to fail is usually sufficient. The other 20% of time is better spent on higher level testing or increasing coverage in other modules. That said, it&#8217;s often worth adding a few unit tests for unsupported configurations to makes sure that your module also fails gracefully and provides informative error messages.</p>

      <h3 id="integration-tests">Integration tests</h3>

      <p>Unit tests are made to test small units of code, integration tests focus on bringing those units together.</p>

      <p>In Puppet, the line between unit tests and integration tests is a bit blurry. It&#8217;s better to think of integration tests and unit tests as two ends of a spectrum, with integration tests focusing on the most complex behavior you expect from your module.</p>

      <p>To get started with integration testing, think of example usage code that you would include in the README of your module or the example usage you&#8217;ve put in the examples directory. If you&#8217;re regularly using the module in one particular way, be sure to include at least that configuration in your integration tests.</p>

      <p>You don&#8217;t need to cover every possible use for your module, just focus your attention on common ones. If you&#8217;re using resource types from other modules, that usage should be covered by your integration tests.</p>

      <h3 id="test-driven-development">Test driven development</h3>

      <p>You might be thinking that the syntax of those tests reads a bit like a specification of how the code should work. For example, you might specify that code by writing &#8220;An apache module that will install the apache package on RedHat and the httpd package on Debian. It should also let you specify an alternate document root.&#8221; etc.</p>

      <p>One very powerful approach is to actually write the tests before writing any code at all. This is known as <code>Test Driven Development</code>.</p>

      <p>Test driven development can help focus on the basic requirements before adding new features, it&#8217;s also a great way to enforce the habit of testing all your code. If you&#8217;re working in a team setting, one useful strategy is for different team members to write the tests and code.</p>

      <p>For those who enjoy solving problems, test driven develop can also add an element of fun. Once the test is written, think of the module as being &#8220;broken&#8221; and your task becomes fixing it. It sounds silly, but it is a really helpful way of reframing your work.</p>

      <!-- End of primary test of the lesson -->

    </div>
    <h3 class="instruction-header">
      <strong><i class="fa fa-desktop"></i> Practice</strong>
    </h3>

    <div class="instruction-content">

      <!-- High level description of the exercise. -->
      <!-------------------------------------------->

      <h3 id="exercises">Exercises</h3>

      <p>We&#8217;ve provided a module with a few fully written tests and a few that only have comments describing the specification. None of the Puppet code is written yet. Take a look at the tests and write some Puppet code to make them pass.</p>

      <!-- End of high level description. -->

    </div>

  </div>

  <div id="terminal">
    <iframe id="try" src="https://try.puppet.com/sandbox/?course=testing" name="terminal"></iframe>
  </div>
</div>