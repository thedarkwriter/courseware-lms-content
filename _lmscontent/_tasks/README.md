# LMS Content

# Automatic deployment

The content in parent folder is converted to html by these tasks using hooks triggered as part of Puppet Pipelines [here](https://pipelines.puppet.com/esquared/apps/courseware-lms-content)


# Manually Testing / Setup Instructions

Clone the repository

```shell
git clone git@github.com:puppetlabs/courseware-lms-content.git
```

Switch to this directory

```shell
cd courseware-lms-content/_lmscontent
```

Install the required gems

```shell
bundle install
```
> The learndot_api gem is now publicly hosted on rubygems.org
> Need a newer version of ruby e.g. `rvm use 2.2.5` or `rbenv shell 2.2.5`

Create a configuration file containing api tokens for github,learndot(staging)
and learndot(production) in the `_tasks` directory. This is in the .gitignore
file and should not be committed to this repo.

```yaml
---
credentials:
  github:
    user: 'acidprime'
    token: '1234512345123451234512345'
  learndot:
    production:
      token: '678910116789101167891011'
    staging:
      token: '121314151617181920'
repos:
  courseware-lms-content:
    url: 'https://github.com/puppetlabs/courseware-lms-content.git'
    branch: 'master'
```

> The `repos` key is used to specify what the git target for where the to be deployed files are.
> This is intentially not the same as the local cloned version of this set of rake tasks
> Rake tasks are loaded from the clone above but content is loaded from the target branch and repo listed in this configuration file.


There is an example copy of this file [here](https://raw.githubusercontent.com/puppetlabs/courseware-lms-content/master/_lmscontent/_tasks/config.yaml.example).

# Rake tasks 

## Deploying to staging

From within this directory `_lmscontent` run the following rake tasks


```shell
rake release:staging
```

This task will search the last commit ( based off the sha of the puppet pipelines shallow repo) for files modified.
The current pattern allows for changes to markdown files to trigger an upload to learndot.

## Fixing missing deployments

```shell
rake release:staging_nightly
```

This task will update the git repo to the lastest copy of the repo as specified
in the `repos` `branch` key. Most days this will be `master`. It then will scan
for changes to markdown files in that subfolders of that directory.

It will limit the scope of files it finds to the last 24 hours as defined by
the clock on the machine its being run from and the git history timestamp. Any
changes to any markdown will trigger the creation of update over the learning
component parent folder. These changes will be deployed just once, meaning if
two files are edited the learning component will receive one update to cut down
on api calls.

All markdown will be converted to html via the [kramdown](https://github.com/gettalong/kramdown) gem.

## Deploying to production

```shell
rake release:production
```

This task will update the git repo to the lastest copy of the repo as specified
in the `repos` `branch` key. Most days this will be `master`. It will then scan
through the repo for the lastest git tag ( Github Release ). It will compare
this release to the last release and generate a list of edited markdown files.
Each learning component that has modifications will be updated or created.

All markdown will be converted to html via the [kramdown](https://github.com/gettalong/kramdown) gem.

# Known limitations

Currently modifications to JSON will not trigger an update. Only changes to
markdown files are being searched for. Simply updating a markdown file in a component directory will however
cause any changes in the json to be uploaded as part of that request.
