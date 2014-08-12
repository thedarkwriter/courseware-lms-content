Puppet Labs LMS VM Contents
=======================

## Synopsis

This repository contains sample code and working files for exercises in the
Puppet Labs LMS system. It is probably not all that useful to you.

### Usage

The modulepath, hieradata, and `hiera.yaml` are synced to the proper places on
the LMS cloud instances. If you need to add or update a module, or Hiera
datasource, just submit a pull request with your updates. As soon as it is
merged, the new content will begin syncing to newly provisioned cloud instances.

I highly suggest that any new exercises exists as part of a module to match
best practices.

If you have other needs, such as needing to create a new directory in `/root`
for serverspec tests to live, then the syncing scripts must be updated.
