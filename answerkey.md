
### Exercise 1: "Quality trimming on 6 Fastq files, *in serial* with multithreading"
* Log into Orchestra using Terminal or Putty or Git BASH

***`ssh ecommonsid@orchestra.med.harvard.edu`***

* Start an interactive session with a single core
 
`bsub -Is -q interactive bash` 

* Change directories into the `~/unix-intro/`, and move the `trimmomatic-serial.lsf` file/script from the `other` directory to your current directory (`~/unix-intro/`)
```
cd unix-intro/
mv other/trimmomatic-serial.lsf .
```

* Open the script with `nano`
 
`nano trimmomatic-serial.lsf`

* Modify the LSF (bsub) directives to use only 4 cores
* Add a bsub directive to make sure that you get an email when the job completes

``` 
# modify the following inside the script
#BSUB -n 4
#BSUB -N
```

* Submit the script to the LSF queue using `bsub` (Hint: Job submissions use special syntax and just `bsub scriptname.lsf` will not work)

`bsub < trimmomatic-serial.lsf`

* Once submitted, immediately check the status of your job. How many jobs do you see running? Is there a difference in the "Queue" on which they are running?

`bjobs`

* When the job is completed it will create a new directory with new files: What is the name of the new directory? How many new files and directories were created within it?

***The new directory is called `trimmed_fastq_LSFout/`, and it has 18 files within it, no directories.***

* List only those files that end in `.zip`, 

`ls -l trimmed_fastq_LSFout/*.zip`


### Exercise 2: "Quality trimming on 6 Fastq files, *in parallel* with multithreading"
* Check and make sure you have an interactive session going and also that you are in the `~/unix-intro/` directory.
* Copy over the `trimmomatic-on-input-file.sh` and `trimmomatic-multithreaded.sh` files from the `other` directory to your current directory

`cp other/trimmomatic*sh .`

* Use `nano` to open the `trimmomatic-multithreaded.sh` file and make note of the bsub submission command in it. Is this a file that can be submitted to LSF using `bsub < scriptname`?

***No, it can't be since it does not have the bsub directives (#BSUB etc.) at the beginning of the script***

* Run `trimmomatic-multithreaded.sh` using sh instead of `bsub <`

`sh trimmomatic-multithreaded.sh`

* How many job submission notifications did you get?

***6 jobs are submitted***

* Once submitted, immediately check the status of your jobs. How many are running and how many are pending?
* Once again, when the job is complete a new directory with new files will be created. Use `ls -l` to determine if the same output was generated for both.
* What do you think the advantage is of running the job(s) this way as compared to Exercise 1?

***This set of scripts ran trimming on a fastq file at a time in a multithreaded fashion, but ran them side-by-side (in parallel) for all 6 files (pending status notwithstanding). Whereas the first script ran trimming in a multithreaded fashion also, but it ran it on the 6 files serially, one after the other.***

***The second exercise was more efficient since it used parallelization (each file had it's own job) and multithreading, instead of only multithreading (all files were run in a single job).***
