###How to classify nodes 

**Why does a user need to know about this topic in order to understand configuration management with PE?**

A class is a block of Puppet code that manages a collection resources related
to a particular aspect of the system you need to manage. For example, a class
might be written to manage a webserver or database. Such a class would include
all the resources needed to download the necessary package or packages,
customize configuration and service files, and manage the associated service.
Bundling all of these resources into a single class, abstracts away the
complexity of the underlying units and allows the component these resources
manage to be addressed as a single unit.

Like a resource, a class must be declared in your Puppet code before it will
actually take effect. While many classes are used within other classes to build
up complex components, at some point you must actually specify which classes
should be applied to a node in your infrastructure and how those classes should
be configured. This step is called **Classification**

Classification is the method used to tell Puppet which classes to declare on
a specific node, and how those classes' parameters should be configured. 

**What does a user need to know before they begin this module in order to succeed?**

To understand classification, a user should have a thorough understanding of
the syntax, purpose, and relationships among the Puppet agent, the Puppet
master, resources, classes, autoloading, manifests, and modules. Specifically,
they should be very comfortable with the distinction between defining and
declaring classes.

Class parameters are an important aspect of classification, but it is possible
to teach a simplified version of classification either without addressing
class parameters (i.e. using only the `include` syntax instead of resource-like
class declarations) or with a much simplified explanation.

To understand class parameters, the user would also need to understand
variables.

Depending on whether the emphasis is on classification through the node
classifier, the emphasis on these prerequisites would be different. If we're
using the `site.pp` manifest, it would be more important for the user to have
an understanding of the Puppet code syntax of the topics mentioned above. If
using the PE console node classifier, this syntax is less important, though the
concepts are still necessary. If using the PE console an introduction to the
console in general and node groups would be necessary.

**What should a user be able to do after completing this module?**

After completing this module, a user should be able to assign classes to nodes
with the `site.pp` file. Using the node groups, the user should be able to
accurately control which classes are applied to which nodes. They should be
able to set the default classification with the `default` node group, target
specific nodes by creating node groups matching their names, and include
multiple nodes in a node group by using regular expressions to match a pattern
in the node name.

The user should be able to avoid unintended effects that might occur if
multiple classifications apply to one node, or if no classifications apply.

**How can we assess the user's comprehension?**

Given a list of several node definitions with varying syntax, the user should
be able to accurately predict which classes will be applied to which nodes.

When supplied with a list of nodes, and the intended classification for each,
The user should be able to write a series of node definitions that would
correctly classify each node.

The user should be able to identify the correct `site.pp` file path among
a set of incorrect alternatives.

This could each be tested by one or more multiple-choice questions.

**What is in/out of scope for learning this topic?**

****

#### Objective 1:  Using the node groups, the user should be able to accurately control which classes are applied to which nodes. They should beable to set the default classification with the `default` node group, target specific nodes by creating node groups matching their names, and include multiple nodes in a node group by using regular expressions to match a patternin the node name.
 

**What sub-topics must be covered to achieve the objective?**

 Sub-Topic 1:
 *  Why do they need to know this?
 *  What are the key points of this topic?
 *  Do you have ideas for how to communicate this idea

 Sub-Topic 2:
 *  Why do they need to know this?
 *  What are the key points of this topic?
 *  Do you have ideas for how to communicate this idea

#### Objective 2: The user should be able to assign classes to nodes with the `site.pp` file.
**What sub-topics must be covered to achieve the objective?**

 Sub-Topic 1:
 *  Why do they need to know this?
 *  What are the key points of this topic?
 *  Do you have ideas for how to communicate this idea?

 Sub-Topic 2:
 *  Why do they need to know this?
 *  What are the key points of this topic?
 *  How will we design it/What instructional tools?

#### Objective 3: The user should be able to avoid unintended effects that might occur if multiple classifications apply to one node, or if no classifications apply.

**What sub-topics must be covered to achieve the objective?**

 Sub-Topic 1:
 *  Why do they need to know this?
 *  What are the key points of this topic?
 *  Do you have ideas for how to communicate this idea?

 Sub-Topic 2:
 *  Why do they need to know this?
 *  What are the key points of this topic?
 *  How will we design it/What instructional tools?
