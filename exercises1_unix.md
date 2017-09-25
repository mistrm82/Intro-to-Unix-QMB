### Exercise 1: "Starting with the shell"

1. Login to O2 and start an interactive session.
2. Change directories into `unix-intro`.
3. List the contents of the `other` directory. How many files are in the folder?
4. Make a copy of the `sequences.fa` file and put it in the `other` folder. Name this file `sequences-copy.fa`.


### Exercise 2: "Paths and shortcuts"

5. Change directories into `other`. List all the `Mov10` FASTQ files in `raw_fastq` from your current directory without changing directories.
6. Do each of the following using a single `ls` command without navigating to a different directory. _HINT: You will want to use a wildcard here._
	a. List all of the files in /bin that start with the letter 'c'
	b. List all of the files in /bin that contain the letter 'a'
	c. List all of the files in /bin that end with the letter 'o'
	BONUS: List all of the files in /bin that contain the letter 'a' or 'c'. (This was not covered in the lesson)

### Exercise 3: "Examining files and redirection"

7. Print the contents of `sequences-copy.fq` to the screen. 
8. Use the `head` command to keep only the frst two sequences of this file. 
9. The last two lines of the file `sequences-copy.fq` represent a protein sequence. Use the `tail` command to take those two lines and redirect them into a new file called `protein.fa`.


### Exercise 4: "Searching and redirection"

10. Let's use the commands we learned and a few new ones to examine our gene annotation file, **`chr1-hg19_genes.gtf`**, and find the genomic coordinates of all known exons on chromosome 1. Move into the `reference_data` folder:

`$ cd ~/unix-intro/reference_data/`

Let's explore our `chr1-hg19_genes.gtf` file a bit. What information does it contain?

`$ less chr1-hg19_genes.gtf`

	chr1    unknown exon    14362   14829   .       -       .       gene_id "WASH7P"; gene_name "WASH7P"; transcript_id "NR_024540"; tss_id "TSS7245";
	chr1    unknown exon    14970   15038   .       -       .       gene_id "WASH7P"; gene_name "WASH7P"; transcript_id "NR_024540"; tss_id "TSS7245";
	chr1    unknown exon    15796   15947   .       -       .       gene_id "WASH7P"; gene_name "WASH7P"; transcript_id "NR_024540"; tss_id "TSS7245";
	chr1    unknown exon    16607   16765   .       -       .       gene_id "WASH7P"; gene_name "WASH7P"; transcript_id "NR_024540"; tss_id "TSS7245";
	chr1    unknown exon    16858   17055   .       -       .       gene_id "WASH7P"; gene_name "WASH7P"; transcript_id "NR_024540"; tss_id "TSS7245";

> The GTF file is a tab-delimited gene annotation file often used in NGS analyses. For more information on this file format, check out the [Ensembl site](http://useast.ensembl.org/info/website/upload/gff.html). 

The columns in the **GTF file contain the genomic coordinates of gene features (exon, start_codon, stop_codon, CDS) and the gene_names, transcript_ids and protein_ids (p_id) associated with these features**. Note that sometimes an exon can be associated with multiple different genes and/or transcripts.

To determine the number of total exons on chromosome 1, we are going to perform a series of steps:
	
	1. Subset the dataset to only include the feature type and genomic location information
	2. Extract only the genomic coordinates of exon features
	3. Remove duplicate exons
	4. Count the total number of exons
	
#### Subsetting dataset
We will define an exon by it's genomic coordinates. Therefore, we only need the feature type and the genomic location (chr, start, stop, and strand) information to find the total number of exons. The columns corresponding to this information are 1, 3, 4, 5, and 7. 

> **HINT: Look up the `cut` command using the `man` pages and/or Google. It is a program that will extract columns from files. It is a very good command to know.  

Let's try out the 'cut' command and take a quick peek at just the first 5 lines to make sure we have the command correct:

`$ cut -f1,3,4,5,7 chr1-hg19_genes.gtf | head -n 5`
   
'-f1,3,4,5,7' means to cut these fields (columns) from the dataset.  

	chr1	exon	14362	14829	-
	chr1	exon	14970	15038	-
	chr1	exon	15796	15947	-
	chr1	exon	16607	16765	-
	chr1	exon	16858	17055	-

	a. Cut these columns from the whole dataset and save it as a file called, **`chr1-hg19genes_cut`**
	b. Check the cut file to make sure that it looks good using `less`. 

####Extracting genomic coordinates of exon features
	c. We only want the exons (not CDS or start_codon features), so let's use `grep` to only keep the exon lines and save to file, **`chr1_exons`**:


#### Removing duplicate exons
	d. Now, we need to remove those exons that show up multiple times for different genes or transcripts.    

	e. We can use a new tool, `sort`, to remove exons that show up more than once.  We can use the `sort` command with the `-u` option to return only unique lines.

		`$ sort -u chr1_exons`

####Counting the total number of exons
	f. Now, to count how many unique exons are on chromosome 1, pipe the `sort` output to the `wc -l` command.
    
**BONUS**

How could have you have determined the number of total exons by combining all of the previous commands (starting with the original chr1-hg19_genes.gtf), into a single command (no intermediate files) using pipes?










