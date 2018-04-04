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

### Step-by-Step Process
1. Tag release in the repository using datevar convention prepended by the letter `v`:   __e.g.:__ v2018.03.01
2. Add a description of what the release contains and then publish release This tag will represent any changes since the LAST push to production. Make your notes as complete as possible
3. Ensure you are in the repo folder on your machine to run the following rake tasks
3. Run a  diff using either either `rake migrate:production` on the command line using compare in GitHub
4. On the command line, run <code>rake download:repo</code> 
5. To finish the process and push all your changes live, run <code>rake release:production</code>
6. Check your content in the [production site](https://learn.puppet.com/)

