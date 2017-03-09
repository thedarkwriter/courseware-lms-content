# Github Fundamentals
At Puppet Labs, we use the Git version control system and the Github web-based hosting service to host our source code.


###Slide 2
This course is a high-level conceptual overview for the github file management cycle. In it you will be introduced to the key environments used in this cycle, and the following supporting topics:

Vocabulary used when describing Github process

Commands used to move data through the content update cycle

How and when to move data between Github environments


###Slide 3
A Github repository is a web-based version-controlled storage container for project source code. 

The Master branch of a repository is the master repository of a project. Development threads that pass quality assurance and are destined to be promoted to production become part of the Master branch.


Since we want to protect the Master repository, we make copies for the development efforts of each member who contributes to the project. Each contributor-specific copy is called a fork.

Before making changes, it's useful to make a copy of the content which you can edit, rather than working on live code. This copy is called a branch.  A branch represents an independent line of development. Examples of branches can include spelling and grammar edits to a current release, and new content intended for a future release.

After you finish your development, you will want to push your work out to a space where it can be validated and merged into the master repository. This web-based instance of your fork is called the origin.

During validation, you will use a sort of web-based quarantine that protects the master repository until someone decides that your work is correct. 

This quarantine is called a pull request. It is the web-based copy of the work you've done, and it's from here that the master will pull in your changes.

Finally, your changes will become part of the master repository. The action of pulling these changes into the master is called merging, and you do it from the Github webpage.

###Slide 4
Your master is what we call the master repository in Git terms, and it resides online at Github.com. This copy represents what you will published as finished code, and it will serve as the basis for all updates. 

You will fetch your copy of the master code from the master repository to your local repository, which resides on your local machine. When you reach a stopping point, you will push your code to the buffer between the local repository and the online master. We call this buffer the origin.


The origin is a copy of your repository that lives at Github.com. It is from your origin that you will issue a pull request. It is also from your origin that the updated code will be merged into the master.


###Slide 5
Now that you have the basics, let's take a more detailed look at how the relationships between these three spaces are managed.


###Slide 6
On the Github site, you can either become a contributor to an existing repository or you can start a new one. Either way, you will need to create a new branch for your development. Remember that a branch is a copy of the master repository that becomes the basis for all of your development for that repository.

Once you create your branch, your development repository is ready for your updates. The next step is to create a working directory on your local computer and synchronize it with your online branch. You will do this from a command prompt.

They key steps to copy the Github repository to your local PC are:

Create a directory called “repositories” to hold all of the work that you will check in and out of github.

Pull a clone (or copy) of your repository down to your local computer. You will do this using the Git Clone command, and the URL of your online repository. This simultaneously points your local computer to your online repository and pulls the content down to your computer. This becomes your working directory.

Remember that, while you are working in only one directory, you will be rolling your work up to the master repository using branches specific to your development effort It’s a good idea to periodically check which branch you are working in. You will use the git checkout command to create the branch on your local computer and sync it with the master repository. You will use git branch to verify which branch you are pointing to.

Now you are ready to work on your project

Any changes you make within the directory you have created and synced with Github will throw modified flags. You can see which files have been added or modified by using the git status command. 

Once you have completed a round of development, you will want to check your changes back in with the master repository. The first command you need to know for this process is Git Add. Git add puts your updated files into a virtual bucket. It tells Git which files to check in. 

Once you have used Git add to add your updated files to the bucket, and you have used Git status to verify that there are no other files that you want to add to this bucket, you are ready to commit your change.

We need to push your changes from your local system to your origin on Github. We need to tell your origin the name of your repo (test-repo) by using the git push command.

To do this, type:
Git push origin test-repo


###Slide 7
By pushing to your origin, you have pushed your content back to your personal copy of the  repository on Github. This step stages your changes so that your colleagues can review, then merge them into the master repository. You can also perform this review and merge yourself if you are the only member of the repository.


###Slide 8

After you push to the origin, you will return to your fork on Github and issue a pull request. The pull request is a quarantine state where reviewers can review your code, but the code has not yet been merged into the master.

Your team, or just you if you are the sole developer, will receive an email with a link to the content that you’ve checked in. 

The reviewer can either approve the update and approve the pull request, or you can send it back and include a message of where the problem is.

If the reviewer chooses to approve the pull request, he or she can merge the update back into the master repository. A merge is the successful completion of a development cycle.


###Slide 9
You have just seen a high-level overview of the Github and it's file management environments. Key topics you have seen are:

Vocabulary used when describing Github process

Commands used to move data through the content update cycle

How and when to move data between Github environments


###Slide 10
Thank you for watching the Github Fundamentals course.
## Video ##

## Exercises ##
There are no exercises for this course.

## Quiz ##

1. True or False. The online quarantine from which you will merge files is called the:
	a. origin
	b. **pull request**
	c. upstream	
	d. buffer
2. Which git command makes your changed files ready to be pushed to the orign?
	a. add
	b. **commit**
	c. push
	d. clone
3. True or False. The git get command will pull a copy of the master repository to your local workstation. **False**
4. True or False. You can use a git status command to see which files in your repository have changed. **True**
5. Using Github provides the following advantages. (Select all that apply)
	a. **Protection of the integrity of the master repository
	b. Protection of the integrity of your personal fork
	c. **Abilty to simultaneously develop for multiple branches
	d. **Ability to validate each other's work before merging it into the master repository.

## References ##
* [Tutorials on Github.com](https://training.github.com/classes/index.html)