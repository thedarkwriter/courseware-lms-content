# An Introduction to Facter
Facter is Puppet’s cross-platform system profiling library. It discovers and reports per-node facts, which are available in your Puppet manifests as variables.

At the end of this course you will be able to:

* describe the type of information stored in Facter.
* demonstrate how to view the information stored in Facter.

## Video
[Link to Video](https://github.com/puppetlabs/courseware-lms/blob/master/03-Technologies/4101/03-4101-Facter_Intro.mp4)

## Exercises
Assuming you have a working Puppet installation:

1. Run the following command on your command line:
`$> facter -p`

## Quiz
1. True or False. Facter stores information about the Puppet Master for your system. (False)
2. Facter stores **facts** as pairs of:
a. variables & values b. keys & values c. node names & values d. resource names & values (b)
3. True or False. Custom facts can be written using Ruby. (True)
4. Facts are top-scope variables. What is considered a best practice for accessing facts in your manifests?
a. $factname b. "$factname" c. ${::factname} d. {$factname} (c)
5. True or False. External facts provide a way to use arbitrary executables or scripts as facts. (True)

## Resources
* [Facter - GitHub](https://github.com/puppetlabs/facter)
* [Puppet Labs Docs](http://docs.puppetlabs.com/facter/)
* [Facter Project Home](http://projects.puppetlabs.com/projects/facter)
* [Facter Homepage](http://puppetlabs.com/puppet/related-projects/facter/)
