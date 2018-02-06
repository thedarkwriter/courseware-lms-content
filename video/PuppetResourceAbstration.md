Video script for "Puppet code abstractions"


Puppet's purpose is to manage resources on a server in your infrastructure.

A **resource** is a piece of Puppet code that manages a characteristic of a server, such as the contents of a file, a user account or a software package to be installed. These characteristics are the same things that a system administrator would manually manage by running commands on a server.


As your server configuration becomes more complex, it makes sense to group related resources together so that you can easily reuse them. You can do this using a Puppet construct called a **class**. A class contains resources that all work together to configure something such as a web server, firewall rules, or kernel configuration settings.

Once resources are contained within a class, the entire class can be easily applied to a server with a simple reference to that class.

As your server configuration becomes even more complex, it makes sense to further organize your code into a module. A module contains a collection of related classes, all working together to configure a specific piece of software or settings on a server.

Puppet gives you the power to express your configuration in code to manage your infrastruture automatically and repeatably.
