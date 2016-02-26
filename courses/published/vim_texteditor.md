# An Introduction to the Vim Text Editor

This course is an introduction to using the Vim text editor to create and edit text files in a Linux environment.  

At the end of this course you will be able to:

* Create a text file in the Vim text editor.
* Edit a text file.
* Navigate within a text file.
* Save a text file and exit the Vim text editor.

## Slide Content

### slide 1
(Title slide)
With Puppet Enterprise, you may need to use a text editor to create and modify Puppet Enterprise program files. This course is a basic introduction to using a text editor in a Linux environment. For simplicity, in this course we use Linux to refer to all unix-like platforms.


### slide 2
There are several good text editors that you can use to write your Puppet code. In this course we look at how to create, edit and navigate in a text file using Vim, a text editor commonly used in Linux and other unix-like operating systems. 

### slide 3
To follow along and practice the skills presented in this course, you need access to a text editor in a Linux environment. To access Vim in the virtual testing environment that we have set up for you, first open a command shell. Then click on the Try It Out Launch button on this course's web page, and then use the internet address provided to securely access the testing environment. If you are working in Windows, you will need an s s h connectivity tool, such as Putty, to access a bash shell. You can also practice on your own at the end of the course.

### slide 4When a command shell opens, you can securely log in to the Linux server.  Although it is not the common practice to work as root, to access the testing environment that we have set up, you will need to log in as root user with the password puppet. 

### slide 5
There are many text editors available, both for free dowload and for purchase.  The one we use in this course to demenostrate and practice concepts is Vim, which is one of the most popular, portable, and powerful. Vim is a derivative of an early full-screen text editor v i, which is still a standard editor on Linux operating systems. Vim stands for V I improved. 

### slide 6
A text editor is a computer application that allows you to create and edit files that contain plain text. This is very different from robust word processing programs that add special formatting which is hidden to the user. When you’re writing computer code, you don’t need or want any special formatting. In fact, your code probably won’t work at all unless it was written and saved in a plain text environment. Because one of the primary uses of text editors is writing and editing in programming and markup languages, many of the features of text editing software are built to help users read and write code. 

### slide 7
A major difference between word processors and text editors is how you navigate in a file. In Vim, you cannot use the mouse to move around in the file. You have to use the keyboard. This can take a little getting use to. You may want to search the internet for a quick reference to use until you become familiar with the key board commands. The Vim website includes some good resources.

### slide 8
Now, to create a new text file with the Vim editor, in a command shell type v im, space, and the name you want for the file. Then press Enter. When you press enter, the command shell changes to display a new text file. 

### slide 9
Like most text editors,  Vim has several modes. The basic ones are insert and command. You are in COMMAND mode when you first create a new text file. You use insert mode to write text, and you use command mode for navigating and entering editor commands, such as help or quit.  To change from command mode to insert mode, type the letter i. The screen changes and the status bar indicates that you are in insert mode. Once you are in insert mode, you can type text. Remember, you can not use the mouse to position the cursor in a text file. But You can use your keyboard arrow keys to move arround. When you are finished typing text, press the escape key to exit insert mode and return to command mode.

### slide 10
In command mode, you use the keyboard to move around in the file so that you can access and manipulate text. Use the arrow keys to move one space left or right, or one line up or down. You can also use h to move left, k to move up, l to move right, and j to move down. To navigate the text in terms of words, type the letter w to move to the start of the next word, type the letter e to move the the end of the current word, and type the letter b to move to the beginning of the current word. You can also combine number keys with movement keys. For example, pressing 3 and w is the same as pressing w three times. And if you press 9 and the letter j, you move the cursor down nine lines.

### slide 11
A few other tips for moving around in a text file are: to move the cursor to the beginning of the current line, press the zero key. To move to the beginning of a specific line, type the line number and an uppercase G. To move to the end of the current line, press the hash key. To move the cursor to the beginning of the file, type two lowercase gees, and to move to the end of the file type an uppercase G. 

### slide 12
And for text that is structured with parenthesis or brackets, you can use the percent sign to jump to the from the opening parenthesis to the closing praenthesis. 

### slide 13
Once you have moved the cursor to where you want to enter new text, type a lowercase i to return to INSERT mode. Type the text, and then press escape to return to COMMAND mode. To insert a new line at the cursor position, in command mode type a lowercase or uppercase O. Then You can go ahead and type a new line of text. Press the escape key when you are ready to return to COMMAND mode. When you are in command mode, you can always type a lowercase i to switch to insert mode, and then press escape to switch back to command mode.  

### slide 14
To delete text, while in command mode, type a lowercase x to delete the character under the cursor, or type an uppercase X to delete the character to the left of the cursor. To replace only one character under the cursor, type an r and then type the replacement character. A lowercase d is the delete command, and you can use it with a movement key to delete a section of text. For example, to delete the first word to the right side of the cursor, type d w. To delete the current line, you type d g g.  

### slide 15
In Vim, to repeat the previous command, simply type a period. To undo the last command, type a lowercase u. And to redo a command,  press control and type an R.  

### slide 16
To save changes to your file, first press the escape key to exit INSERT mode. Then type a colon, to access the command line, and then type a w for write. If you want to continue writing, type an i to re-enter INSERT mode. When you are ready to save your changes and exit the text editor, type a colon, a w for write and  q for quit. If you want to exit a file without saving your changes, you can type a q and an exclamation point. And for help in Vim, while you are in command mode, type a colon and then the word help.   

### slide 17
In this short introductory course, we looked at how to access the Vim text editor, how to create and edit a text file, and how to navigate around in a text file. If you want, you can access the  private, virtual testing environment to practice using the Vim text editor on your own. 

### slide 18
To take a short quiz, to check your knowledge, and for more information about how to use a text editor,  click the links at the bottom of this course's page. 

### slide 19
Thank you for completing this Introduction to the Vim Text Editor Puppet Labs Workshop course. 


## Quiz
1. True or False. Word processor and text editor applications produce the same kind of output. 
	**False**
2. Which one of the following is a characteristic of a plain text file?  
	a. Plain text files include  special formatting hidden to the user.
	b. **Plain text files do not add special formatting to the text.**
	c. Plain text files are accessible to programmers only.
	d. Plain text files are available only in a Linux environment.
3. Which of the following methods can you use to navigate in a text file? Select all that apply.
	a. **keyboard commands**
	b. computer mouse buttons
	c. **keyboard directional arrow keys**
	d. **number keys combined with keyboard commands**
	e. mouse buttons combined with keyboard commands
4. In a text file, how do you exit INSERT mode?
	a. Type a colon (:).
	b. At the command line, type EXIT.
	c. Type a colon (:), and a q.
	d. **Press the escape (esc) key.**
5. True or False. Vim is a derivative of an early full screen editor called v i.
	**True**

## References
* [Vim Documentation](http://www.vim.org/docs)
* [Vim Blog](http://puppetlabs.com/blog/vim-tool-for-learning-puppet)
