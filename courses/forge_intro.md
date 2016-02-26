# An Introduction to the Forge
The Puppet Forge is a community of content creators. It is also a repository of modules written by our community of Puppet users for both Puppet Open Source and Puppet Enterprise IT automation software.

At the end of this course you will be able to:

* Explain what the Puppet Forge is.
* Determine your need for modules on the Forge.
* Create an account on the Forge.
* Download modules from & submit modules to the Forge.

## Video ##
[Link to Video](http://linktovideo)

## Exercises ##
Assuming you have a working Puppet installation:

1. Create a Puppet Forge user account (if you do not currently have one). [Sign Up](http://forge.puppetlabs.com/signup)

2. Search for a VMWare Tools module (i.e. vmwaretools) both online and from the command line using `puppet module`.
3. Choose a vmwaretools module (or appropriate module for you to test) and download it.
	* For example, [CraigWatson1987](http://forge.puppetlabs.com/CraigWatson1987/vmwaretools)
	* You can also use the Puppet Module Tool to install the module. (Available in Puppet 2.7.14+ and Puppet Enterprise 2.5+. [More Information](http://docs.puppetlabs.com/puppet/2.7/reference/modules_installing.html#installing-from-the-puppet-forge))

## Quiz ##
1. True or False. The Puppet Forge is a repository for Puppet modules that can be downloaded and used in your own Puppet installation. (True)

2. Which command will search the Puppet Forge for a PuppetDB module?
a. `puppet search puppetdb` b. `puppet forge puppetdb` c. `puppet module search puppetdb` d. `puppet search forge puppetdb` (c)

3. The module metadata (name, version, source, author, description, etc.) are placed in a text file called the:
a. modulefile b. module-desc c. forgefile d. README (a)

4. True or False. The following command will build a tar.gz file that you can upload to the Puppet Forge: (True)
`puppet module build <modulepath>`

5. True or False. When installing a module from the Puppet Forge (see example), Puppet will not install module dependencies. (False)
`puppet module install puppetlabs-puppetdb`

## Resources ##
* [Puppet Forge](http://forge.puppetlabs.com/)
