Puppet LMS Content
=======================

This repo contains the source code and transcripts for the self-paced courses on learn.puppet.com.

The _lmscontent directory is connected to Distelli; commits will be automatically converted to HTML and pushed up to the LearnDot staging instance.  Tagged releases will deploy to the production instance.  For additional information on that, please see the [readme](_lmscontent/README.md).

This repo only contains markdown, images, and transcripts; for video files, please see TBD.

Getting Started
=======================

Based on our current workflow, you do not need to fork this repo.  You may fork it if you want to and submit PRs through the standard git workflow, but it is **not** required.

Clone this repo to your local development environment.

    git clone https://github.com/puppetlabs/courseware-lms-content.git
    
Each directory in _lmscontent represents a learning component in LearnDot.  The content.md, description.md, and summary.md are converted to HTML and uploaded to the appropriate field; the remaining LearnDot fields are populated via the metadata.json file.  **Do not edit the metadata.json file,** unless you are familiar with LearnDot's idiosyncrasies.

### Updating Existing Materials to Staging

* Using the editor of your choice, update the relevant markdown files for a learning component.
* Once you are done editting, stage the files for commit.
  * `git add <file name>`
* When you have staged all the files that you want to commit, create a commit.
  * `git commit`
  * Depending on your setup, this will open up an editor for you to write a commit message.  Please refer to our Contribution Guidelines for how to format your commit message.
* Push your commit up to this repo.
  * `git push origin master`
  * This assumes that you have not forked this repo and updated your remote names.

You may now log into the [staging instance](https://puppetlabs-staging.trainingrocket.com/) and view your changes.

### Creating a New Learning Component

* Create a new directory within _lmscontent.
  * The directory name is not too important, but it is suggested that it match the URL endpoint where the component will be listed.
* Copy the contents of _lmscontent/example into the new directory.
* Edit the following fields in the metadata.json:
  * Name - This is the public facing name of the component
  * Duration.days and duration.minutesPerDay
  * Price
  * **Do not edit the other fields unless you have checked with someone else first**
* Follow the steps for updating components, starting with staging.

Related Projects
=======================

[LearnDot API Wrapper](https://github.com/puppetlabs/learndot_api) - Used for the Distelli automated deployment.

[Magicbox](https://github.com/WhatsARanjit/magicbox) - Embedded in self-paced courses for interactive exercises.

Contact 
==========

eduteam@puppet.com
