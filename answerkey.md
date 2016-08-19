
### Exercise 1: "Quality trimming on 6 Fastq files, *in serial* with multithreading"
* Log into Orchestra using Terminal or Putty or Git BASH
* Start an interactive session with a single core
* Change directories into the `~/unix-intro/`, and move the `trimmomatic-serial.lsf` file/script from the `other` directory to your current directory (`~/unix-intro/`)
* Open the script with `nano` 
* Modify the LSF (bsub) directives to use only 4 cores
* Add a bsub directive to make sure that you get an email when the job completes
* Submit the script to the LSF queue using `bsub` (Hint: Job submissions use special syntax and just `bsub scriptname.lsf` will not work)
* Once submitted, immediately check the status of your job. How many jobs do you see running? Is there a difference in the "Queue" on which they are running?
* When the job is completed it will create a new directory with new files: What is the name of the new directory? How many new files and directories were created within it?
* List only those files that end in `.zip`, 


### Exercise 2: "Quality trimming on 6 Fastq files, *in parallel* with multithreading"
* Check and make sure you have an interactive session going and also that you are in the `~/unix-intro/` directory.
* Copy over the `trimmomatic-on-input-file.sh` and `trimmomatic-multithreaded.sh` files from the `other` directory to your current directory
* Use `nano` to open the `trimmomatic-multithreaded.sh` file and make note of the bsub submission command in it. Is this a file that can be submitted to LSF using `bsub < scriptname`?
* Run `trimmomatic-multithreaded.sh` using sh instead of `bsub <`
* How many job submission notification did you get?
* Once submitted, immediately check the status of your jobs. How many are running and how many are pending?
* Once again, when the job is complete a new directory with new files will be created. Use `ls -l` to determine if the same output was generated for both.
* What do you think the advantage is of running the job(s) this way as compared to Exercise 1?


