The `/etc/motd` file is presented to users each time they log in. We would like to allow non-admins to easily customize this login message.

Familiarize yourself with the hiera.yaml configuration file.

`vim /etc/puppetlabs/code/hiera.yaml`

Identify the `datadir` where yaml configuration files are located. Edit the `common.yaml` datasource, which will set common values for all nodes in your environment and set an motd key to define your `/etc/motd` message.

`vim /etc/puppetlabs/code/hieradata/common.yaml`

Keys can be retrieved with the `hiera()` function. Verify that your key is set properly by running puppet and executing that function inline:

`puppet apply -e 'notice(hiera("motd"))'`

Change your current working directory to your modulepath

`cd /etc/puppetlabs/code/modules`

Examine the directory structure of the example motd module.

    [root@training modules]# tree motd/
    motd/
    ├── manifests
    │   └── init.pp
    ├── Modulefile
    ├── README
    ├── spec
    │   └── spec_helper.rb
    └── tests
        └── init.pp

Edit the main class manifest file and replace the value of the content parameter with a `hiera()` function call to look up the data dynamically.

`vim motd/manifests/init.pp`

Validate your syntax and enforce your class. and apply the class. Your `/etc/motd` file should contain the data retrieved from your `common.yaml` datasource.

*   `puppet parser validate motd/manifests/init.pp`
*   `puppet apply motd/tests/init.pp`

Looking at the `hiera.yaml` file again, identify the datasource that would provide an override for your node’s fully qualified domain name. This fqdn can be found by executing `facter fqdn`.

Create that file, and provide an alternate motd message. Without making any changes to your manifest, enforce it again and verify that the overridden message is propagated to your `/etc/motd` file.
