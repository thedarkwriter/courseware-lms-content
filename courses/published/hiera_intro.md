# An Introduction to Hiera
Hiera is a key/value lookup tool for configuration data, built to make Puppet better and let you set node-specific data without repeating yourself. Hiera support is built into Puppet 3, and is available as an add-on for Puppet 2.7.

At the end of this course you will be able to: 

*   Describe the benefits of data separation with Hiera.
*   Explain a use case of Hiera and its basic configuration syntax.

## Video
[Link to Video](http://linktovideo)

## Exercises
1. The `/etc/motd` file is presented to users each time they log in. We would like to allow non-admins to easily customize this login message.

Familiarize yourself with the hiera.yaml configuration file:

`vim /etc/puppetlabs/puppet/hiera.yaml`

2. Identify the `datadir` where yaml configuration files are located. Edit the `common.yaml` datasource, which will set common values for all nodes in your environment and set an motd key to define your `/etc/motd` message:

`vim /etc/puppetlabs/puppet/hieradata/common.yaml`

3. Keys can be retrieved with the `hiera()` function. Verify that your key is set properly by running puppet and executing that function inline:

`puppet apply -e 'notice(hiera("motd"))'`

4. Change your current working directory to your module path:

`cd /etc/puppetlabs/puppet/modules`

5. Examine the directory structure of the example motd module:

<pre><code>[root@training modules]# tree motd/
motd/
├── manifests
│   └── init.pp
├── Modulefile
├── README
├── spec
│   └── spec_helper.rb
└── tests
    └── init.pp
</pre>

6. Edit the main class manifest file and replace the value of the content parameter with a `hiera()` function call to look up the data dynamically:

`vim motd/manifests/init.pp`

7. Validate your syntax and enforce your class. and apply the class. Your `/etc/motd` file should contain the data retrieved from your `common.yaml` datasource.

*   `puppet parser validate motd/manifests/init.pp`
*   `puppet apply motd/tests/init.pp`

8. Looking at the `hiera.yaml` file again, identify the datasource that would provide an override for your node’s fully qualified domain name. This fqdn can be found by executing `facter fqdn`.

9. Create that file, and provide an alternate motd message. Without making any changes to your manifest, enforce it again and verify that the overridden message is propagated to your `/etc/motd` file.

## Quiz
1. True or False. Hiera is primarily useful in separating configuration data from your Puppet modules. (True)

2. Which of the following is not a benefit, as listed in the video?
	a. Hiera makes it easier to configure your own nodes.
	b. Hiera makes it easier to re-use public Puppet modules.
	c. **Hiera makes it easier to configure your Puppet Master during installation.**
	d. Hiera makes it easier to publish your own modules.

3. True or False. Hiera allows for PostgreSQL backends. (True)

4. When searching the data backends Hiera will:
	a. **Begin with the first backend listed.**
	b. Search all backends listed.
	c. Randomly search the backends listed.
	d. Traverse the listed backends from bottom up.

5. True or False. The Hiera configuration file must be a valid YAML hash file. (True)

## Resources
* [Hiera - Github](https://github.com/puppetlabs/hiera)
* [Hiera - Docs](http://docs.puppetlabs.com/hiera/1/)
* [Hiera - Project Page](http://projects.puppetlabs.com/projects/hiera)
