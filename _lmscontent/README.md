# LMS Content

## Git workflow

![Git workflow](README/git_workflow.svg "Content publishing workflow")

Changes in this folder are automatically detected by distelli (Puppet
pipelines) and will publish to the [learndot staging environment](https://puppetlabs-staging.trainingrocket.com/login.html).
Each commit in github will cause a "build" job to run and detect the changes
and publish the entire contents of the learning component. This means changes
to `summary.md` also results in `content.md` and any metadata to be
updated in learndot.



## Folder structure 

![Learning component folder structure](README/git_learndot.svg "Learning component folder structure")

Folders in this directory are representative of learning components. As learning
component should be reusable, a flat structure is preferred. However some
legacy content in this directory exists and is organized into sub folders.

All fields except `summary`,`content` and `discription` exist as key value
pairs in the `metadata.json` file. A template for this file exists
[here](https://github.com/puppetlabs/courseware-lms-content/blob/master/_lmscontent/_tasks/defaults.json).

 The `summary`,`content` and `discription` fields are represented as
 [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
 files. See the diagram above.

> Ensure that you create both a unique `name` and `urlName` keys in your
> `metadata.json` file. For advanced users the `rake` command will automate
> this, but requires you have the ruby gems setup on your laptop correctly.

# Publishing to production

![Git workflow](README/production_publish.svg "Production publishing")

All commits made to this repo that contain changes to the learning components in
this folder are pushed to staging. Production changes are published by new
[releases](https://github.com/puppetlabs/courseware-lms-content/releases/new)
being created on the repo. These must be in the format `v1.0`. Its recommended
to use the [Semantic versioning](https://semver.org/) standard when determining
the number for a release. E.g. `v1.0` vs `v2.0` represents a "breaking" change.
