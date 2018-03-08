What are **resources**? In Puppet parlance, resources are characteristics of a server that need to be managed over time, such as creating a user, installing a package or setting a kernel parameter.

These are the same things a sysadmin would manually manage at the command line or with a GUI application. The power of resources is you can express system configuration in code to automate it and apply it consistently to one or more servers.

Resources define the **end state** of a server, not the steps required to achieve that state. You will write code that defines the desired end state (or final configuration) of a server, and Puppet will be responsible for applying the changes required to get it into and keep it in that state.

As you start to write and edit your own Puppet code, you want to be sure your syntax is correct so it can be understood by Puppet. Watch the following video about syntax. Pay particular attention to the rules regarding use of curly braces, quotes, and commas.

<script src="https://fast.wistia.com/embed/medias/6te1c1owui.jsonp" async></script><script src="https://fast.wistia.com/assets/external/E-v1.js" async></script><div class="wistia_responsive_padding" style="padding:56.25% 0 0 0;position:relative;"><div class="wistia_responsive_wrapper" style="height:100%;left:0;position:absolute;top:0;width:100%;"><div class="wistia_embed wistia_async_6te1c1owui seo=false videoFoam=true" style="height:100%;width:100%">&nbsp;</div></div></div>
<br>
For this course, you will only explore the syntax at the resource level. But understanding how this all works together will help you in the future. In the rest of this course, you will work on a scenario that helps you apply this information.

<img src="/static/images/courses/syntax/363-anatomy-of-a-resource-narrow-2.png" alt="Diagram of the parts of a resource" width="100%" height="100%" />

These are the components of a resource statement in the Puppet language. Every resource is comprised of a type, a title, and list of attributes.

**What is a type?**

Every resource is associated with a resource **type**, which describes what kind of configuration it manages and provides knobs and settings for configuring that resource. Puppet has many built-in resource types, like files, cron jobs, services, etc. You used the `file` type when you wrote Hello world in Puppet code earlier in this course. See the <a href="https://puppet.com/docs/puppet/latest/type.html" target="_blank">resource type reference</a> for information about the built-in resource types.

**What is a title?**

A **title** is a string that identifies a resource to Puppet. A title doesn't have to match the name of what you're managing on the target system, but you'll often want it to. In the Hello world example, the title of the file resource was `/etc/motd`, which is the location of the file managed by Puppet.

**What are attributes?**

**Attributes** describe the desired state of the resource and each attribute handles some aspect of the resource. Think of them as the knobs and settings that let you describe the desired state of the resource. For example, you can say that Puppet should make sure that the `owner` of a file is `student` by setting the attribute as in the example above. Each resource type has its own set of available attributes. See the <a href="https://puppet.com/docs/puppet/latest/type.html" target="_blank">resource type reference</a> for a complete list. Most resource types have a handful of crucial attributes and a larger number of optional ones.

**What are values?**

Every attribute you declare must have a **value**. The format of the value depends on what the attribute accepts. For example, the value might need to be a file path, IP address, or a true/false value.

<blockquote>
<p><strong>Pro Tip:</strong></p>
<p>There are many third-party modules you can install that deliver more resource types, such as the <a href="https://forge.puppet.com/puppetlabs/mysql" target="_blank">puppetlabs/mysql</a> module that adds the <code>mysql_user</code> resource type. You can find and install modules by browsing the <a href="http://forge.puppetlabs.com/" target="_blank">Puppet Forge</a>.</p>
</blockquote>

Puppet can see a variety of attributes about a file or any resource type. Some examples of other attributes might include **mode**, **ensure**, **owner**, or **group**. The `puppet resource` command shows you all the attributes Puppet knows about a resource, as well as their values. This is useful for identifying and examining the characteristics of any given file.

## Task:

Enter the `puppet resource` command to see all the attributes of the `file` at `/etc/motd`.

<iframe src="https://magicbox.classroom.puppet.com/syntax/querying_the_system" width="100%" height="300px" frameborder="0"></iframe>

Now that you can see all the attributes Puppet knows about the file at `/etc/motd`, you also know the things you can manage about that file. To change the value of an attribute using Puppet, you will use the same syntax from the previous exercise, replacing the old values with your new values.

## Task:

Change the `mode` attribute from `0644` to `0600`.

<iframe src="https://magicbox.classroom.puppet.com/syntax/modifying_attributes" width="100%" height="400px" frameborder="0"></iframe>

<blockquote><hr />
<p><strong>Pro Tip</strong>:<br><br>Often you and your peers will want to agree on things like using spaces or tabs in your code, number of indents to use, or whether or not you like the trailing comma. Puppet will interpret your code the same regardless of spaces, tabs, or indents. But to have some consistency to how code is written, you might want to use what is referred to as a <strong>style guide</strong>. Puppet's <a href="https://puppet.com/docs/puppet/5.3/style_guide.html" target="_blank">style guide</a> helps Puppet community members write code to be easily shared and read by other community members.</p>
<p>Luckily, there is a command you can run to check a file containing Puppet code and let you know if the syntax is correct or not. This command is <code>puppet parser validate</code> followed by the name of the file that you want to check. For example, if you have a file called <code>default.pp</code> containing Puppet code that you want to check, you'd type <code>puppet parser validate default.pp</code> on the command line.</p>
<p>The best place to learn how to correctly write your Puppet code is in the <a href="https://puppet.com/docs/puppet/latest/lang_visual_index.html" target="_blank">Puppet Docs</a>. Be sure&nbsp;to&nbsp;also&nbsp;bookmark the <a href="https://validate.puppet.com/" target="_blank">Puppet Validator</a>&nbsp;where you can paste Puppet code and test its validity.</p>
</blockquote>

## Task:

Use the `puppet parser validate` command to validate the `test.pp` file. Use any error output to fix any syntax errors and rerun the command if necessary.

<iframe src="https://magicbox.classroom.puppet.com/syntax/validating_your_syntax" width="100%" height="300px" frameborder="0"></iframe>
