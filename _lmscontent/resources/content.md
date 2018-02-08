<!--
This is the template for the self-paced courses.
Put your content in between the comments that mark
out the different sections.  Text should be written
in markdown.
-->
<link rel="stylesheet" href="/static/selfpaced/selfpaced.css" />

<script src="https://try.puppet.com/js/selfpaced.js"></script>

<script defer="" src="https://code.jquery.com/jquery-1.11.2.js"></script>

<div id="lesson">
  <div id="instructions">
    <div class="instruction-header">
      <p><i class="fa fa-graduation-cap"></i>
Lesson</p>
    </div>
    <div class="instruction-content">
      <!-- Primary Text of the lesson -->
      <!-------------------------------->

      <h1 id="resources">Resources</h1>

      <p><strong>Resources</strong> are the fundamental building blocks of Puppet&#8217;s declarative
modeling syntax. Learning about resources will help you understand how Puppet
represents and interacts with a system you want it to manage.</p>

      <p>At the end of this course you will be able to:</p>

      <ul>
        <li>Understand how resources on the system are modeled in Puppet&#8217;s Domain Specific
Language (DSL).</li>
        <li>Use Puppet to inspect resources on your system.</li>
        <li>Use the Puppet Apply tool to make changes to resources on your system.</li>
        <li>Learn about the Resource Abstraction Layer (RAL).</li>
      </ul>

      <h2 id="resources-1">Resources</h2>

      <p>Puppet&#8217;s foundation is a system called the <em>resource abstraction layer</em>.
Puppet interprets any aspect of your system configuration you want to manage
(users, files, services, and packages, to give some common examples) as a unit
called a <em>resource</em>. Puppet knows how to translate back and forth between the
resource syntax and the &#8216;native&#8217; tools of the system it&#8217;s running on. Ask
Puppet about a user, for example, and it can represent all the information
about that user as a resource of the <em>user</em> type. Of course, it&#8217;s more useful
to work in the opposite direction. Describe how you want a user resource to
look, and Puppet can go out and make all the changes on the system to actually
create or modify a user to match that description.</p>

      <p>The block of code that describes a resource is called a <strong>resource
declaration</strong>.  These resource declarations are written in Puppet code, a
Domain Specific Language (DSL) based on Ruby.</p>

      <h3 id="puppets-domain-specific-language">Puppet&#8217;s Domain Specific Language</h3>

      <p>A good understanding of the Puppet DSL is a key first step in learning how to
use Puppet effectively. While tools like the PE console give you quite a bit of
power to make configuration changes at a level above the code implementation,
it always helps to have a solid understanding of the Puppet code under the
hood.</p>

      <p>Puppet&#8217;s DSL is a <em>declarative</em> language rather than an <em>imperative</em> one. This
means that instead of defining a process or set of commands, Puppet code
describes (or declares) only the desired end state. With this desired state
described, Puppet relies on built-in <em>providers</em> to handle implementation.</p>

      <p>One of the points where there is a nice carry over from Ruby is the <em>hash</em>
syntax. It provides a clean way to format this kind of declarative model, and
is the basis for the <em>resource declarations</em> you&#8217;ll learn about in this quest.</p>

      <p>As we mentioned above, a key feature of Puppet&#8217;s declarative model is that it
goes both ways; that is, you can inspect the current state of any existing
resource in the same syntax you would use to declare a desired state.</p>

      <p>The <code>puppet resource</code> tool lets you see how Puppet represents resources on
a system. The syntax of the command is: <em>puppet resource &lt;type&gt; &lt;name&gt;</em>.</p>

      <p>The command <code>puppet resource user root</code>, will return something like the
following, though the exact details might vary depending on your operating
system and the details of the root user account.</p>

      <pre>
    user { 'root':
      ensure           =&gt; present,
      comment          =&gt; 'root',
      gid              =&gt; '0',
      home             =&gt; '/root',
      password         =&gt; '$1$jrm5tnjw$h8JJ9mCZLmJvIxvDLjw1M/',
      password_max_age =&gt; '99999',
      password_min_age =&gt; '0',
      shell            =&gt; '/bin/bash',
      uid              =&gt; '0',
    }
</pre>

      <p>This resource declaration syntax is composed of three main components:</p>

      <ul>
        <li>Type</li>
        <li>Title</li>
        <li>Attribute value pairs</li>
      </ul>

      <p>We&#8217;ll go over each of these below.</p>

      <h3 id="resource-type">Resource Type</h3>

      <p>You&#8217;ll get used to the resource syntax as you use it, but for this first look
we&#8217;ll go through the example point by point.</p>

      <p>We&#8217;ll start with the first line first:</p>

      <pre>
  user { 'root':
    ...
  }
</pre>

      <p>The word <code>user</code>, right <em>before</em> the curly brace, is the <strong>resource type</strong>.
The type represents the kind of thing that the resource describes. It tells
Puppet how to interpret the rest of the resource declaration and what kind of
providers to use for managing the underlying system details.</p>

      <p>Puppet includes a number of built-in resource types, which allow you to manage
aspects of a system. Below are some of the core resource types you&#8217;ll encounter
most often:</p>

      <ul>
        <li><code>user</code> A user</li>
        <li><code>group</code> A user group</li>
        <li><code>file</code> A specific file</li>
        <li><code>package</code> A software package</li>
        <li><code>service</code> A running service</li>
        <li><code>cron</code> A scheduled cron job</li>
        <li><code>exec</code> An external command</li>
        <li><code>host</code> A host entry</li>
      </ul>

      <p>If you are curious to learn about all of the built-in resources types
available, see the <a href="http://docs.puppetlabs.com/references/latest/type.html">Type Reference
Document</a>
or try the command <code>puppet describe --list</code>.</p>

      <h3 id="resource-title">Resource Title</h3>

      <p>Take another look at the first line of the resource declaration.</p>

      <pre>
  user { 'root':
    ...
  }
</pre>

      <p>The single quoted word <code>'root'</code> just before the colon is the resource
<strong>title</strong>.  Puppet uses the resource title as its own internal unique
identifier for that resource. This means that no two resources of the same type
can have the same title.</p>

      <p>In our example, the resource title, <code>'root'</code>, is also the name of the user
we&#8217;re inspecting with the <code>puppet resource</code> command. Generally, a resource
title will match the name of the thing on the system that the resource is
managing. A package resource will usually be titled with the name of the
managed package, for example, and a file resource will be titled with the full
path of the file.</p>

      <p>Keep in mind, however, that when you&#8217;re creating your own resources, you can
set these values explicitly in the body of a resource declaration instead of
letting them default to the resource title. For example, as long as you
explicitly tell Puppet that a user resource&#8217;s <code>name</code> is <code>'root'</code>, you can
actually give the resource any title you like. (<code>'superuser'</code>, maybe, or even
<code>'spaghetti'</code>) Unless you have a good reason to do otherwise, however, using
a title that will also provide a valid value for the namevar will make your
code more concise and readible.</p>

      <h3 id="attribute-value-pairs">Attribute Value Pairs</h3>

      <p>Now that we&#8217;ve covered the <em>type</em> and <em>title</em>, take a look at the body of the
resource declaration.</p>

      <pre>
user { 'root':
  ensure           =&gt; present,
  comment          =&gt; 'root',
  gid              =&gt; '0',
  home             =&gt; '/root',
  password         =&gt; '$1$jrm5tnjw$h8JJ9mCZLmJvIxvDLjw1M/',
  password_max_age =&gt; '99999',
  password_min_age =&gt; '0',
  shell            =&gt; '/bin/bash',
  uid              =&gt; '0',
}
</pre>

      <p>After the colon in that first line comes a hash of <strong>attributes</strong> and their
corresponding <strong>values</strong>. Each line consists of an attribute name, a <code>=&gt;</code>
(pronounced &#8216;hash rocket&#8217;), a value, and a final comma. For instance, the
attribute value pair <code>home =&gt; '/root',</code> indicates that root&#8217;s home is set to the
directory <code>/root</code>.</p>

      <p>So to bring this all together, a resource declaration will match the following
pattern:</p>

      <pre>
type {'title':
    attribute =&gt; 'value',
}
</pre>

      <p>Note that the comma at the end of the final attribute value pair isn&#8217;t required
by the parser, but it is best practice to include it for the sake of
consistency. Leave it out, and you may forget to insert it when you add another
attribute value pair on the following line!</p>

      <!-- End of primary test of the lesson -->
    </div>
    <div class="instruction-header">
      <p><i class="fa fa-desktop"></i>
Practice</p>
    </div>
    <div class="instruction-content">
      <!-- High level description of the exercise. -->
      <!-------------------------------------------->
      <p>Now it&#8217;s your turn to try it out. Using the sandbox environment we&#8217;ve provided
for this lesson, use the <code>puppet resource</code> tool to investigate some other
resource types.
<!-- End of high level description. --></p>
    </div>
    <div class="instruction-header">
      <p><i class="fa fa-square-check-o"></i>
Instructions</p>
    </div>
    <div class="instruction-content">
      <!-- Step by step instructions -->
      <!-------------------------------->

      <p>First, let&#8217;s take a look at the <code>network</code> service. Before running any command,
take a moment to guess how Puppet might represent a service on the system. What
essential information would puppet need to know about the state of a service?</p>

      <pre><code>puppet resource service network
</code></pre>

      <p>To see what these parameters mean and find the full set of parameters and
values for the <code>service</code> resource type, either visit the <a href="https://docs.puppet.com/puppet/latest/type.html">Resource Type
Reference</a> docs page or use
the <code>puppet describe</code> command.</p>

      <pre><code>puppet describe service
</code></pre>

      <p>What do you think would happen if you ran the <code>puppet resource service</code> command
without specifying a resource title? Go ahead and give it a try.</p>

      <pre><code>puppet resource service
</code></pre>

      <p>Puppet will show you the state of all the services it can find on your system.</p>

      <p>Now that you know your way around a resource, pick another resource type and
use the <code>puppet resource</code> and <code>puppet describe</code> commands to explore that type.
(Note that if you pick the <code>file</code> resource type, <code>puppet resource file</code> will
result in an error message. Why do you think this is?)</p>

      <!-- End of step by step instruction -->
    </div>

    <div class="instruction-header"></div>

  </div>
  <div id="terminal">
    <iframe name="terminal" src="https://try.puppet.com/sandbox/"></iframe>
  </div>
</div>