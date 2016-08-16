---
title: "The Shell: Searching and Redirection"
author: "Sheldon  McKay, Bob Freeman, Mary Piper"
date: "Thursday, May 5, 2016"
---

Adapted from the lesson by Tracy Teal.
Contributors: Paul Wilson, Milad Fatenejad, Sasha Wood, and Radhika Khetani for Software Carpentry (http://software-carpentry.org/)

## Saving time with tab completion, wildcards and other shortcuts

#### Tab Completion

Navigate to the home directory. Typing out directory names can waste a lot of time. When you start typing out the name of a directory, then hit the tab key, the shell will try to fill in the rest of the directory name. For example, type `cd` to get back to your home directly, then enter:

```$ cd uni<tab>```

The shell will fill in the rest of the directory name for `unix-intro`. Now go to `unix-intro/raw_fastq` and 

```$ ls Mov10_oe_<tab><tab>```

When you hit the first tab, nothing happens. The reason is that there are multiple directories in the home directory which start with `Mov10_oe_`. Thus, the shell does not know which one to fill in. When you hit tab again, the shell will list the possible choices.

Tab completion can also fill in the names of commands. For example, enter `e<tab><tab>`. You will see the name of every command that starts with an `e`. One of those is `echo`. If you enter `ec<tab>` you will see that tab completion works. 

> **Tab completion is your friend!** It helps prevent spelling mistakes, and speeds up the process of typing in the full command.

#### Wild cards

Navigate to the `/home/username/unix-intro/raw_fastq` directory. This
directory contains FASTQ files from our RNA-Seq experiment. 

The '*' character is a shortcut for "everything". Thus, if you enter `ls *`, you will see all of the contents of a given directory. Now try this command:

```$ ls *fq```

This lists every file that ends with a `fq`. This command:

```$ ls Mov10*fq```

lists only the files that begin with 'Mov10' and end with 'fq'

So how does this actually work? The shell (bash) considers an asterisk "*" to be a wildcard character that can be used to substitute for any other single character or a string of characters. 

> An asterisk/star is only one of the many wildcards in UNIX, but this is the most powerful one and we will be using this one the most for our exercises.

#### Other shortcuts

There are some more shortcuts which you should know about. Dealing with the
home directory is very common. So, in the shell the tilde character,
"~", is a shortcut for your home directory. Navigate to the `raw_fastq`
directory:

```$ cd```

```$ cd unix-intro/raw_fastq```

Then enter the command:

```$ ls ~```

This prints the contents of your home directory, without you having to type the full path because the tilde "~" is equivalent to "/home/username".

Another shortcut that you are already familiar with is the "..":

```$ ls ..```

The shortcut `..` always refers to the directory above your current directory. So, it prints the contents of the `unix-intro`. You can chain these together, so:

```$ ls ../..```

prints the contents of `/home/username` which is your home directory. 

Finally, the special character `.` always refers to your current directory. So, `ls`, `ls .`, and `ls ././././.` all do the same thing, they print the contents of the current directory. This may seem like a useless shortcut right now, but it is very useful for specifying a destination when copying or moving files/folders.

To summarize, while you are in your home directory, the commands `ls ~`, `ls ~/.`, and `ls /home/username` all do exactly the same thing. These shortcuts are not necessary, but they are really convenient!

## Examining Files

We now know how to move around the file system and look at the
contents of directories, but how do we look at the contents of files?

The easiest way to examine a file is to just print out all of the
contents using the command `cat`. Print the contents of `unix-intro/other/sequences.fa` by entering the following command:

`$ cat ~/unix-intro/other/sequences.fa`

This prints out the all the contents of `sequences.fa` to the screen.

> `cat` stands for catenate; it has many uses and printing the contents of a files onto the terminal is one of them.

What does this file contain?

`cat` is a terrific command, but when the file is really big, it can be annoying to use. The command, `less`, is useful for this case. Let's take a look at the raw_fastq files. These files are quite large, so we probably do not want to use the `cat` command to look at them. Instead, we can use the `less` command. 

Move back to our `raw_fastq` directory and enter the following command:

`less Mov10_oe_1.subset.fq`

The `less` command opens the file, and lets you navigate through it. The keys used to move around the file are identical to the `man` command.

**Some commands in `less`**

| key     | action |
| ------- | ---------- |
| "space" | to go forward |
|  "b"    | to go backwards |
|  "g"    | to go to the beginning |
|  "G"    | to go to the end |
|  "q"    | to quit |

Hit 'q' to exit the `less` interface and get the command prompt back.

There are many different ways to examin file contents, like `head` and `tail` and they just let you look at the beginning and end of a file respectively.

```$ head Mov10_oe_1.subset.fq ```

```$ tail Mov10_oe_1.subset.fq```

The `-n` argument to either of these commands can be used to print the first or last `n` lines of a file. To print the first/last line of the file use:

```$ head -n 1 Mov10_oe_1.subset.fq```

```$ tail -n 1 Mov10_oe_1.subset.fq```

## Creating, moving, copying, and removing

What if we want to do normal things like copy files or move them around or get rid of them. Sure we could do most of these things without the command line, but what fun would that be?! Besides it's often faster to do it at the command line, or you'll be on a remote server like Amazon where you won't have another option.

Our raw data in this case is fastq files. We don't want to change the original files,
so let's make a copy to work with.

Lets copy the file using the copy `cp` command. Navigate to the `raw_fastq` directory and enter:

```$ cp Mov10_oe_1.subset.fq Mov10_oe_1.subset-copy.fq```

```$ ls -l```

Now ``Mov10_oe_1.subset-copy.fq`` has been created as a copy of `Mov10_oe_1.subset.fq`

Let's make a 'backup' directory where we can put this file.

The `mkdir` command is used to make a directory. Just enter `mkdir`
followed by a space, then the directory name.

```$ mkdir backup```

> File/directory/program names with spaces in them do not work in unix, use characters like hyphens or underscores instead.

We can now move our backed up file in to this directory. We can move files around using the command `mv`. Enter this command:

```$ mv *copy.fq backup```

```$ ls -al backup```

	drwxrwsr-x 2 mp298 mp298       43 Sep 30 13:59 .
	drwxrwsr-x 8 mp298 mp298      203 Sep 30 13:58 ..
	-rw-rw-r-- 1 mp298 mp298 75706556 Sep 30 13:56 Mov10_oe_1.subset-copy.fq

The `mv` command is also how you rename files and directories.

`$ mv backup fastq_backup`

`$ ls`

> Both `mv` and `cp` require that you specify 2 things after the command on the command line: first is the object being copied, moved or renamed, and the second is the destination it's being moved or copied to, or the new name!

Finally, we decided this was not what we needed to do, and we want to start over

	$ rm fastq_backup/Mov10_oe_1.subset-copy.fq

> The `rm` file permanently removes the file. Be careful with this command. The shell doesn't
just nicely put the files in the Trash. They're really gone.
>
> Same with moving and renaming files. It will **not** ask you if you are sure that you want to "replace existing file".

By default, `rm`, will NOT delete directories, but you use the `-r` option if you are sure that you want to delete the directories and everything within them. 

	$ rm -r fastq_backup
	
> `-r` stands for recursive. 

## Writing files

We've been able to do a lot of work with files that already exist, but what if we want to write our own files. Obviously, we're not going to type in a FASTA file, but you'll see as we go through other tutorials, there are a lot of reasons we'll want to write a file, or edit an existing file.

To write in files, we're going to use the command `nano`. We're going to create
a file that contains some text. We'll name this file 'awesome.txt'.

```$ nano awesome.txt```

Now you have something that looks like

![nano1.png](../img/nano1.png)

Type in a sentence, something like "nano is awesome"

Now we want to save the file and exit. At the bottom of nano, you see the "\^X Exit". That means that we use Ctrl-X to exit. Type `Ctrl-X`. It will ask if you want to save it. Type `y` for yes. Then it asks if you want that file name. Hit 'Enter'.

Now you've written a file. You can take a look at it with less or cat, or open it up again and edit it.

**Commands, options, and keystrokes covered in this lesson**

```bash
cd
ls
man
pwd
~ (home dir)
. (current dir)
.. (parent dir)
*  (wildcard)
echo
ctrl-C (cancel current command)
ctrl-R (reverse history search)
ctrl-A (start of line)
ctrl-E (end of line)
history
! (repeat cmd)
cat
less
head
tail
cp
mdkir
mv
rm
nano
```


## Searching files

We showed a little how to search within a file using `less`. We can also
search within files without even opening them, using `grep`. Grep is a command-line
utility for searching plain-text data sets for lines matching a string or regular expression.
Let's give it a try!

Suppose we want to see how many reads in our file are really bad, with 10 consecutive Ns  
Let's search for the string NNNNNNNNNN in file 

`$ cd ~/unix_workshop/raw_fastq`

`$ grep NNNNNNNNNN Mov10_oe_1.subset.fq`

We get back a lot of lines.  What if we want to see the whole fastq record for each of these reads?
We can use the '-B' and '-A' arguments for grep to return the matched line plus one before (-B 1) and two
lines after (-A 2). Since each record is four lines and the second line is the sequence, this should
give the whole record.

`$ grep -B1 -A2 NNNNNNNNNN Mov10_oe_1.subset.fq`

for example:

	@HWI-ST330:304:H045HADXX:1:1101:1111:61397
	CACTTGTAAGGGCAGGCCCCCTTCACCCTCCCGCTCCTGGGGGANNNNNNNNNNANNNCGAGGCCCTGGGGTAGAGGGNNNNNNNNNNNNNNGATCTTGG
	+
	@?@DDDDDDHHH?GH:?FCBGGB@C?DBEGIIIIAEF;FCGGI#########################################################
	--
	@HWI-ST330:304:H045HADXX:1:1101:1106:89824
	CACAAATCGGCTCAGGAGGCTTGTAGAAAAGCTCAGCTTGACANNNNNNNNNNNNNNNNNGNGNACGAAACNNNNGNNNNNNNNNNNNNNNNNNNGTTGG
	+
	?@@DDDDDB1@?:E?;3A:1?9?E9?<?DGCDGBBDBF@;8DF#########################################################

****
**Exercise**

1) Search for the sequence CTCAATGAAGAAATCTCTTAAAC in `Mov10_oe_1.subset.fq`.
In addition to finding the sequence, have your search also return
the name of the sequence.

2) Search for that sequence in all Mov10 replicate fastq files.
****

## Redirection

We're excited we have all these sequences that we care about that we
just got from the FASTQ files. That is a really important motif
that is going to help us answer our important question. But all those
sequences just went whizzing by with grep. How can we capture them?

We can do that with something called "redirection". The idea is that
we're redirecting the output from the terminal (all the stuff that went
whizzing by) to something else. In this case, we want to print it
to a file, so that we can look at it later.

The redirection command for putting something in a file is `>`

Let's try it out and put all the sequences that contain 'NNNNNNNNNN'
from all the files in to another file called `bad_reads.txt`.

`$ grep -B1 -A2 NNNNNNNNNN Mov10_oe_1.subset.fq > bad_reads.txt`

The prompt should sit there a little bit, and then it should look like nothing
happened. But type `ls`. You should have a new file called `bad_reads.txt`. Take
a look at it and see if it has what you think it should.

If we use '>>', it will append to rather than overwrite a file.  This can be useful for saving more than one search, for example:
    
`$ grep -B1 -A2 NNNNNNNNNN Mov10_oe_2.subset.fq >> bad_reads.txt`

Since our `bad_reads.txt` file isn't a raw_fastq file, we should move it to a different location within our directory. We decide to move it to the `other` folder using the command `mv`. 

`$ mv bad_reads.txt ../other/`

There's one more useful redirection method that we're going to show, and that's
called the pipe, written as `|`. It's probably not a key on
your keyboard you use very much. What `|` does is take the output of one command that went
scrolling by on the terminal and runs it through another command.
When it was all whizzing by before, we wished we could just slow it down and
look at it, like we can with `less`. Well it turns out that we can! We pipe
the `grep` command to `less`

`$ grep -B1 -A2 NNNNNNNNNN Mov10_oe_1.subset.fq | less`

Now we can use the arrows to scroll up and down and use `q` to get out.

We can also do something tricky and use the command `wc`. `wc` stands for
*word count*. It counts the number of lines or characters. So, we can use
it to count the number of lines we're getting back from our `grep` command.
And that will magically tell us how many sequences we're finding.

`$ grep NNNNNNNNNN Mov10_oe_1.subset.fq | wc`

This command tells us the number of lines, words and characters in the file. If we
just want the number of lines, we can use the `-l` flag for `lines`.

`$ grep NNNNNNNNNN Mov10_oe_1.subset.fq | wc -l`

Redirecting is not super intuitive, but it's really powerful for stringing
together these different commands, so you can do whatever you need to do.

The philosophy behind these commands is that none of them
really do anything all that impressive. BUT when you start chaining
them together, you can do some really powerful things really
efficiently. If you want to be proficient at using the shell, you must
learn to become proficient with the pipe and redirection operators:
`|`, `>`, `>>`.

##Practice with searching and redirection

Finally, let's use the new tools in our kit and a few new ones to examine our gene annotation file, **chr1-hg19_genes.gtf**, which we will be using later to find the genomic coordinates of all known exons on chromosome 1.

`$ cd ~/unix_workshop/reference_data/`

Let's explore our `chr1-hg19_genes.gtf` file a bit. What information does it contain?

`$ less chr1-hg19_genes.gtf`

	chr1    unknown exon    14362   14829   .       -       .       gene_id "WASH7P"; gene_name "WASH7P"; transcript_id "NR_024540"; tss_id "TSS7245";
	chr1    unknown exon    14970   15038   .       -       .       gene_id "WASH7P"; gene_name "WASH7P"; transcript_id "NR_024540"; tss_id "TSS7245";
	chr1    unknown exon    15796   15947   .       -       .       gene_id "WASH7P"; gene_name "WASH7P"; transcript_id "NR_024540"; tss_id "TSS7245";
	chr1    unknown exon    16607   16765   .       -       .       gene_id "WASH7P"; gene_name "WASH7P"; transcript_id "NR_024540"; tss_id "TSS7245";
	chr1    unknown exon    16858   17055   .       -       .       gene_id "WASH7P"; gene_name "WASH7P"; transcript_id "NR_024540"; tss_id "TSS7245";

> The GTF file is a tab-delimited gene annotation file often used in NGS analyses. For more information on this file format, check out the [Ensembl site](http://useast.ensembl.org/info/website/upload/gff.html). 

The columns in the **GTF file contain the genomic coordinates of gene features (exon, start_codon, stop_codon, CDS) and the gene_names, transcript_ids and protein_ids (p_id) associated with these features**. Note that sometimes an exon can be associated with multiple different genes and/or transcripts. For example, 

`$ grep FAM138* chr1-hg19_genes.gtf | head -n 5`

This search returns two different genes, FAM138A and FAM138F, that contain the same exon.

`$ grep PLEKHN1 chr1-hg19_genes.gtf | head -n 5`

This search returns two different transcripts of the same gene, NM_001160184 and NM_032129, that contain the same exon.

Now that we know what type of information is inside of our gtf file, let's explore our commands to answer a simple question about our data: **how many total exons are present on chromosome 1 using `chr1-hg19_genes.gtf`?**

To determine the number of total exons on chromosome 1, we are going to perform a series of steps:
	
	1. Subset the dataset to only include the feature type and genomic location information
	2. Extract only the genomic coordinates of exon features
	3. Remove duplicate exons
	4. Count the total number of exons
	
####Subsetting dataset
We will define an exon by it's genomic coordinates. Therefore, we only need the feature type and the genomic location (chr, start, stop, and strand) information to find the total number of exons. The columns corresponding to this information are 1, 3, 4, 5, and 7. 

'cut' is a program that will extract columns from files.  It is a very good command to know.  Let's first try out the 'cut' command on a small dataset (just the first 5 lines of chr1-hg19_genes.gtf) to make sure we have the command correct:

`$ cut -f1,3,4,5,7 chr1-hg19_genes.gtf | head -n 5`
   
'-f1,3,4,5,7' means to cut these fields (columns) from the dataset.  

	chr1	exon	14362	14829	-
	chr1	exon	14970	15038	-
	chr1	exon	15796	15947	-
	chr1	exon	16607	16765	-
	chr1	exon	16858	17055	-

The `cut` command assumes our data columns are separated by tabs (i.e. tab-delimited). The `chr1-hg19_genes.gtf` is a tab-delimited file, so the default `cut` command works for us. However, data can be separated by other types of delimiters. Another common delimiter is the comma, which separates data in comma-separated value (csv) files. If your data is not tab delimited, there is a `cut` command argument (-d) to specify the delimiter.

Our output looks good, so let's cut these columns from the whole dataset (not just the first 5 lines) and save it as a file, **`chr1-hg19genes_cut`**:

`$ cut -f1,3,4,5,7 chr1-hg19_genes.gtf > chr1-hg19genes_cut`

Check the cut file to make sure that it looks good using `less`. 

####Extracting genomic coordinates of exon features
We only want the exons (not CDS or start_codon features), so let's use `grep` to only keep the exon lines and save to file, **`chr1_exons`**:

`$ grep exon chr1-hg19genes_cut > chr1_exons`

#### Removing duplicate exons
Now, we need to remove those exons that show up multiple times for different genes or transcripts.    

We can use a new tool, `sort`, to remove exons that show up more than once.  We can use the `sort` command with the `-u` option to return only unique lines.

`$ sort -u chr1_exons`

####Counting the total number of exons
Now, to count how many unique exons are on chromosome 1, we need to pipe the output to `wc -l`:

`$ sort -u chr1_exons | wc -l`
    

****
**Exercise**

How could have you have determined the number of total exons by combining all of the previous commands (starting with the original chr1-hg19_genes.gtf), into a single command (no intermediate files) using pipes?

****

**Commands, options, and keystrokes covered in this lesson**

```bash
grep
> (output redirection, write to file)
>> (output redirection, append to file)
| (output redirection, take output from previous command as input to the next command)
wc
cut
sort
```

---
*To share or reuse these materials, please find the attribution and license details at [license.md](https://github.com/hbc/Intro-to-Unix/blob/master/license.md).*

