### Exercise 1: "Starting with the shell"

1. Login to O2 and start an interactive session.

**Answer:** `ssh ecommonsID@o2.hms.harvrd.edu`

2. Change directories into `unix-intro`.

**Answer:** `cd unix-intro`

3. List the contents of the `other` directory. How many files are in the folder?

**Answer:** `ls -l other`

4. Make a copy of the `sequences.fa` file and put it in the `other` folder. Name this file `sequences-copy.fa`.

**Answer:** `cp other/sequences.fa other/sequences-copy.fa`


### Exercise 2: "Paths and shortcuts"

5. Change directories into `other`. List all the `Mov10` FASTQ files in `raw_fastq` from your current directory without changing directories.

**Answer:**
 
```cd other
   ls -l ../raw-fastq/Mov10*
 ```

6. Do each of the following using a single `ls` command without navigating to a different directory. _HINT: You will want to use a wildcard here._

**Answer:**

	* List all of the files in /bin that start with the letter 'c': `ls /bin/c*`
	* List all of the files in /bin that contain the letter 'a': `ls /bin/*a*`
	* List all of the files in /bin that end with the letter 'o': `ls /bin/*o`
	* BONUS: List all of the files in /bin that contain the letter 'a' or 'c'. (This was not covered in the lesson): `ls *[ac]*`

### Exercise 3: "Examining files, searching and redirection"

7. Print the contents of `sequences-copy.fq` to the screen. 

**Answer:** `cat sequences-copy.fq`

8. Use the `head` command to keep only the first two sequences of this file. 

**Answer:** `head -n 2 sequences-copy.fa`

9. The last two lines of the file `sequences-copy.fa` represent a protein sequence. Use the `tail` command to take those two lines and redirect them into a new file called `protein.fa`.

**Answer:** `tail -n 2 sequences-copy.fa > proetin,fa`

10. Use `grep` to search for the patterm `CAGCT` in the `sequences-copy.fa` file. Use your shell knowledge to count how many times that pattern appears in the file. Now use the `man` pages to find out how you can count using the `grep` command. 

**Answer:** `grep CAGCT sequences-copy.fa | wc -l`

	     `grep -c CAGCT sequences-copy.fa | wc -l`

