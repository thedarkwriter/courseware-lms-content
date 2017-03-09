# An Introduction to Hiera
Hiera is a key/value lookup tool for configuration data, built to make Puppet better and let you set node-specific data without repeating yourself. Hiera support is built into Puppet 3, and is available as an add-on for Puppet 2.7.

At the end of this course you will be able to: 

*   Describe the benefits of data separation with Hiera.
*   Explain a use case of Hiera and its basic configuration syntax.

## Video
[Link to Video](http://linktovideo)

## Transcript

## Slide 0



## Slide 1

Hiera is a key/value lookup tool for configuration data, built to make Puppet better and let you set node-specific data without repeating yourself.

## Slide 2

Hiera makes Puppet better by keeping site-specific data out of your manifests. Puppet classes can request whatever data they need, and your Hiera data will act like a site-wide config file.

## Slide 3

This makes it:
    Easier to configure your own nodes: default data with multiple levels of overrides is finally easy.
    Easier to re-use public Puppet modules: don’t edit the code, just put the necessary data in Hiera.
    Easier to publish your own modules for collaboration: no need to worry about cleaning out your data before showing it around, and no more clashing variable names.

## Slide 4

With Hiera, you can:
    Write common data for most nodes
    Override some values for machines located at a particular facility…
    …and override some of those values for one or two unique nodes.
This way, you only have to write down the differences between nodes. When each node asks for a piece of data, it will get the specific value it needs.

## Slide 5

To get started with Hiera, you’ll need to do the following:
    Install Hiera, if it isn’t already installed.
    Make a hiera.yaml config file.
    Arrange a hierarchy that fits your site and data.
    Write data sources.
    Use your Hiera data in Puppet (or any other tool).

## Slide 6

This is a sample hiera.yaml configuration file for Hiera. Use this file to configure the hierarchy, which backend(s) to use, and settings for each backend.

Hiera’s config file must be a YAML hash. The file must be valid YAML, but may contain no data.

Hiera will fail with an error if the config file can’t be found, although an empty config file is allowed.


:backends
Must be a string or an array of strings, where each string is the name of an available Hiera backend. The built-in backends are yaml and json; an additional puppet backend is available when using Hiera with Puppet. Additional backends are available as add-ons.
The list of backends is processed in order: in the example above, Hiera would check the entire hierarchy in the yaml backend before starting again with the json backend.
Default value: "yaml"

:hierarchy
Must be a string or an array of strings, where each string is the name of a static or dynamic data source. (A dynamic source is simply one that contains a %{variable} interpolation token. See “Creating Hierarchies” for more details.)
The data sources in the hierarchy are checked in order, top to bottom.
Default value: "common" (i.e. a single-element hierarchy whose only level is named “common.”)

## Slide 7

Using the previous configuration we have created a data directory called dev.yaml. In this file we have 2 key/value pairs. One for ntpserver and an array for dnsservers.

## Slide 8

Hiera will search for key value pairs, for example the ntpserver key/value pair from our dev.yaml file, in the following order: 1. /etc/puppet/hieradata/hosts/agent.puppetlabs.vm.yaml
2. /etc/puppet/hieradata/env/dev.yaml 
3. /etc/puppet/hieradata/common.yaml

## Slide 9

While this has been a short and simple introduction to Hiera, you can hopefully see the advantages of separting your common configuration data from your modules.

Remember, with Hiera, you can:
    Write common data for most nodes
    Override some values for machines located at a particular facility…
    …and override some of those values for one or two unique nodes.
This way, you only have to write down the differences between nodes. When each node asks for a piece of data, it will get the specific value it needs.

## Slide 10





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
