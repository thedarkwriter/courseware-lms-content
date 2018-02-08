## TERMINOLOGY! DOCS! VIDEO!
&nbsp;

Anatomy of a Resource

What are **resources**? Resources are a single unit of something that you can make changes to using Puppet code. It might be as small as a single <code>file</code>, or it might be as large as a whole Apache virtual host. What's important is that a resourse is a singular thing that can be managed as a whole unit. They are composed of four main parts: a type, a title, attributes, and values. In the Hello, World example, you managed the <code>/etc/motd</code> resource.

Diagram of the parts of a resource

###### Enlarge image
Explore each one of these components in greater detail.

**What is a type?**

Every resource is associated with a resource** type**, which describes what kind of configuration it manages and provides knobs and settings for configuring that resource. Puppet has many built-in resource types, like files, cron jobs, services, etc. See the [resource type reference](https://puppet.com/docs/puppet/latest/type.html "") for information about the built-in resource types. You used the file type when you wrote Hello world in Puppet code earlier in this course.

**What is a title?**

The **title** is a string that identifies a resource to Puppet. A title doesn&rsquo;t have to match the name of what you&rsquo;re managing on the target system, but you&rsquo;ll often want it to. In the Hello world example, the title of the file resource was <code>/etc/motd,</code> which is the location of the file.

**What are attributes?**

**Attributes** describe the desired state of the resource and each attribute handles some aspect of the resource. Think of them as the knobs and settings that let you describe the desired state of the resource. For example, you can say that Puppet should make sure that the <code>owner</code> of a file is <code>student</code> by setting the attribute as in the example above. Each resource type has its own set of available attributes. See the [resource type reference](https://puppet.com/docs/puppet/5.3/type.html "") for a complete list. Most resource types have a handful of crucial attributes and a larger number of optional ones.

**What are values?**

Every attribute you declare must have a **value**. The format of the value depends on what the attribute accepts. For example, the value might need to be a file path, IP address, or a true/false.

<blockquote>
**Pro Tip:**

There are many third party modules you can install that deliver more resource types, such as the [puppetlabs/mysql](https://forge.puppet.com/puppetlabs/mysql "") module that adds the <code>mysql_user</code> resource type. You can find and install modules by browsing the [Puppet Forge](http://forge.puppetlabs.com/ "").

</blockquote>