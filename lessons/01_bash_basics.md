---
title: "The Shell"
author: "Sheldon  McKay, Mary Piper, Radhika Khetani"
---

Adapted from the lesson by Tracy Teal.
Original contributors:
Paul Wilson, Milad Fatenejad, Sasha Wood and Radhika Khetani for Software Carpentry (http://software-carpentry.org/)

## Learning Objectives
- How do you access the shell?
- How do you use it?
  - Getting around the Unix file system
  - looking at files
  - manipulating files
  - automating tasks
- What is it good for?
- Where are resources where I can learn more? (because the shell is awesome)


## Setting up

We will spend most of our time learning about the basics of the shell by manipulating some experimental data.

Since we are going to be working with this data on our remote server, **Orchestra**, we first need to log onto the server. After we're logged on, we will each make our own copy of the example data folder.

#### Logging onto Orchestra with Macs

Using the Terminal, you can use the command 'ssh' and your eCommons username to login. Type:

```ssh username@orchestra.med.harvard.edu```

You will receive a prompt for your password, and you should type in your ECommons password. 

#### Logging onto Orchestra with Windows

By default, there is no terminal for the bash shell available in the Windows OS, so you have to use a downloaded program, **[Putty](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html)**.

When you open Putty, you will see the following GUI.

![Putty window](../img/putty-1.PNG)

Type in "orchestra.med.harvard.edu" in the window under "Host Name (or IP address) and click on "Open"

![Connect to Orchestra](../img/putty-2.PNG)

A warning window will pop up the first time you try to connect to a cluster (remote server), say "Yes". Once you do that, you should be able to enter your login ID which is your eCommons ID. Add ID and press enter.

![Log in](../img/putty-5.PNG)

Once you press enter, it will prompt you for a password. Type in your password, when you do this nothing will appear on the screen until you press enter. When you press enter, the interface will change and you have started a bash terminal.

#### Copying example data folder

Once logged in, you should see the Orchestra news and the command prompt: 

```$ ```

The command prompt will have some characters before it, this is telling you the name of the login node/computer you are working on.  

Just like with `>` in R, when you see the `$`, it means that bash is ready to start accepting commands from you.

The first command we will type on the command prompt will be to start a so-called "interactive session" on Orchestra.

```$ bsub -Is -q interactive bash```

Press enter after you type in that command. You will get a couple of messages, but in a few seconds you should get back the command prompt `$`; the string of characters before the command prompt, however, have changed. They should say something like `rsk27@clarinet002-062`; the clarinets (or bassoons etc.) are worker nodes on Orchestra.

Make sure that your command prompt is now preceded by a character string that contain words like "clarinet", "bassoon", etc. We want to do all of our work on the worker nodes, and not on the head/login node.

Copy the example data folder to your home directory using the following command:

```$ cp -r /groups/hbctraining/unix_workshop/ unix-intro ```  

`cp` is the command for copy. 

This command required you to specify the location of the item(s) you want to copy (`/groups/hbctraining/unix_workshop/`) and the location of the destination (`unix-intro`); please note the space between the 2 in the command. The "-r" is an option/argument that modifies the copy command to do something slightly different than usual. 

## Starting with the shell

We have each created our own copy of the example data folder into our home directory, **unix-intro**. Let's go into the data folder and explore the data using the shell.

```$ cd unix-intro```

> 'cd' stands for 'change directory'

Let's see what is in here. Type:

```$ ls```

You will see:

	genomics_data  other  raw_fastq  README.txt  reference_data

> ls stands for 'list' and it lists the contents of a directory.

There are five items listed.  What are they? We can use a "modifier" with `ls` to get more information; this modifier is called an argument.

```$ ls -l```

`ls -l` gives a lot more information than just `ls`.

	total 124
	drwxrwsr-x 2 mp298 mp298  78 Sep 30 10:47 genomics_data
	drwxrwsr-x 6 mp298 mp298 107 Sep 30 10:47 other
	drwxrwsr-x 2 mp298 mp298 228 Sep 30 10:47 raw_fastq
	-rw-rw-r-- 1 mp298 mp298 377 Sep 30 10:47 README.txt
	drwxrwsr-x 2 mp298 mp298 238 Sep 30 10:47 reference_data
	
We are not going to talk about permissions in this module, but that is what is denoted in the first column; in addition to permissions, note the first character. The first character denotes whether something is a directory/folder (`d`) or not. Let's move into the raw_fastq directory and see what is in there.

```$ cd raw_fastq/```

```$ ls -l```

None of the six items in this directory have pemissions that start with a `d`, so they are all files. In fact, they are all fastq files (sequence data) as the name suggests.


#### Arguments

Most commands take additional arguments that control their exact behavior. For example, `-l` is an argument to `ls`.  The `ls` command, like many commands, take a lot of arguments. Another useful one is `-h`, which shows the size of the file in human-readable format. There are many ways to figure out what the various arguments for a command are, but Google is your best bet here. (You can also use the `man` command to get the manual for a given command, e.g. `man ls`.)


## The Unix directory file structure (a.k.a. where am I?)
 
As you've already just seen, you can move around in different directories or folders at the command line. 


Like on any computer you have used before the file structure within unix is hierarchical, like an upside down tree with root (/) as the starting point of the tree-like structure:

![Unix](../img/Slide1.jpg)

That root (/) is often also called the 'top' level.

When you log in to a remote computer you are on one of the branches of that tree, your home directory (e.g. /home/username)

> On mac OS, which is a UNIX-based OS, the root level is also "/". On a windows OS, it is drive specific; generally "C:\" is considered root, but it changes to "D:/", if you are on that drive.

#### Moving around the file system

Let's practice moving around a bit.

We're going to work in that `unix-intro` directory.

Type

```
$ pwd    # this is equivalent to getwd() in R

$ cd
```

To go 'back up a level' we can use `..`

Type:

```$ cd ..```

Now do `ls` and `pwd`. 

> `..` denotes parent directory, and you can use it anywhere in the system to go back to the parent directory. Can you think of an example when this won't work?


#### Examining the contents of other directories

By default, the `ls` commands lists the contents of the working directory (i.e. the directory you are in). You can always find the directory you are in using the `pwd` command. However, you can also give `ls` the names of other directories to view. Navigate to the home directory if you are not already there.

Type:

```$ cd```

Then enter the command:

```$ ls unix-intro/```

This will list the contents of the `unix-intro` directory without you having to navigate there.

The `cd` command works in a similar way.

```
$ cd unix-intro/raw_fastq/
$ pwd
```

You should now be in `raw_fastq` and you got there without having to go through the intermediate directory. 

> If you are aware of the directory structure, you can string together as long a list as you like.


## Full vs. Relative Paths

The `cd` command takes an argument which is the directory name. Directories can be specified using either a *relative path* or a *full path*. As we know, the directories on the computer are arranged into a hierarchy. The full path tells you where a directory is in that hierarchy. Navigate to the home directory (`cd`). Now, enter the `pwd` command and you should see:

`$ pwd`

`/home/username`

which is the full path for your home directory. This tells you that you are in a directory called `username`, which sits inside a directory called `home` which sits inside the very top directory in the hierarchy, the *root directory*. So, to summarize: `username` is a directory in `home` which is a directory in `/`.

Now enter the following commands

```
$ cd /home/username/unix-intro/raw_fastq/

$ pwd
```

This jumps to `raw_fastq`. Now go back to the home directory (`cd`). We saw
earlier that the command:

```$ cd unix-intro/raw_fastq/```

had the same effect - it took us to the `raw_fastq` directory. But, instead of specifying the full path (`/home/username/unix-intro/raw_fastq`), we specified a *relative path*. In other words, we specified the path **relative to our current working directory**. 

A *full* path always starts with a `/`, a *relative* path does not!

You can usually use either a full path or a relative path depending on what is most convenient. If we are in the home directory, it is more convenient to just enter the relative path since it involves less typing.

#### Information on the shell

shell cheat sheets:<br>
* [http://fosswire.com/post/2007/08/unixlinux-command-cheat-sheet/](http://fosswire.com/post/2007/08/unixlinux-command-cheat-sheet/)
* [https://github.com/swcarpentry/boot-camps/blob/master/shell/shell_cheatsheet.md](https://github.com/swcarpentry/boot-camps/blob/master/shell/shell_cheatsheet.md)

Explain shell - a web site where you can see what the different components of
a shell command are doing.  
* [http://explainshell.com](http://explainshell.com)
* [http://www.commandlinefu.com](http://www.commandlinefu.com)

Software Carpentry tutorial: [The Unix shell](http://software-carpentry.org/v4/shell/index.html)

General help:
- http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html
- man bash
- Google - if you don't know how to do something, try Googling it. Other people
have probably had the same question.
- Learn by doing. There's no real other way to learn this than by trying it
out.  Write your next paper in nano (really emacs or vi), open pdfs from
the command line, automate something you don't really need to automate.

---
*To share or reuse these materials, please find the attribution and license details at [license.md](https://github.com/hbc/Intro-to-Unix/blob/master/license.md).*

