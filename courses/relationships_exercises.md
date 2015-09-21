Login shells are the programs that users interact with. They interpret commands typed at the command line. We would like to provide a new shell for our users. This requires that we install a package, and also customize a configuration file. The configuration file should be updated after the package is installed, just in case the package installs a default and overwrites our customizations.

Change your current working directory to your modulepath with:

`cd /etc/puppetlabs/code/modules`

Examine the directory structure of the example `zsh` module:

    [root@training modules]# tree zsh/
    zsh/
    ├── files
    │   ├── zshrc
    │   └── zshrc.dev
    ├── manifests
    │   └── init.pp
    ├── Modulefile
    ├── README
    ├── spec
    │   └── spec_helper.rb
    └── tests
        └── init.pp

Edit the manifest file inside the zsh module to add this relationship between the two resources.
