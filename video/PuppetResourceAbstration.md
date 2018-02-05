Video script for "Puppet code abstractions"

Note: Italic font indicates alternate/extra wording
Note: Bold font indicates questions to be resolved

Puppet's purpose is to manage resources on a server [in your infrastructure].

A resource is a piece of Puppet code that manages a characteristic of a server, such as the contents of a file, a user account or a software package to be installed. These characteristics are the same things that a system administrator would manually manage by running commands on a server.

Puppet gives you the power to express the configuration of your machine as a collection of resources in Puppet code and manage them automatically and repeatably.

[-As your server configuration becomes more complex It makes sense to- What about this reword?] You can group related resources into a Puppet construct called a class. A class contains resources that all work together to configure something such as a web server, firewall rules or kernel configuration settings.

Once resources are contained within a class, the entire class [of resources] can be easily applied to a server with a simple reference to that class. [clear enough/makes sense? YES!]

As your server configuration becomes even more complex, it makes sense to further organize your code into a module. A module contains a collection of related classes, all working together to configure a specific piece of software or settings on a server.

I would actually move the below paragraphs to the page that the video will appear on. This is only b/c I think we could use this video in a larger/longer video that DOES cover the Forge. What do you think? The wording is perfect! I am just thinking of recyclability 
For example, there is a module on the Puppet Forge to configure the Apache web server. Apache is sufficiently complex that there are many classes contained in the module to give maximum flexibility to the user when configuring it [setting it up (?)].

The Puppet Forge is a huge resource of pre-built modules written by Puppet and our community, and it will be covered in another course. For now, we'll focus on how Puppet code is built, and when you start learning about the Forge, you'll see those modules follow the same structure as what you've been building.