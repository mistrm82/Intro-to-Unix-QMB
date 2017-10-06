
### Exercise 1: "Quality trimming on 6 Fastq files, *in serial* with multithreading"

* Log into O2 using Terminal (on Macs) or Git BASH (on Windows)

**Answer:** `ssh ecommonsid@o2.hms.harvard.edu`

* Start an interactive session with a single core
 
**Answer:** `srun -p interactive --pty --mem 8000 -t 0-12:00 /bin/bash `

* Change directories into the `~/unix-intro/`, and copy over files using the following command:

```
  $ cp /n/groups/hbctraining/unix-intro/other/*-slurm* . 
```

**Answer:**

```
cd unix-intro/
cp /n/groups/hbctraining/unix-intro/other/*-slurm* . 
```

* Open the `trimmomatic-serial-slurm.sbatch` script with `nano` 
 
**Answer:** `nano trimmomatic-serial-slurm.sbatch`

* Modify the SLURM (`SBATCH`) options to use only 4 cores
* Add the `SBATCH` options to make sure that you get an email when the job completes/ends

**Answer:**

`# modify the following inside the script`

`#SBATCH -n 4`

`SBATCH –-mail-user=your_email@med.harvard.edu`

`#SBATCH --mail-type=END`

Submit the script to the SLURM queue using `sbatch`

**Answer:** `sbatch trimmomatic-serial-slurm.sbatch`

* Once submitted, immediately check the status of your job. How many jobs do you see running? Is there a difference in the "partition" on which they are running?

**Answer:** `squeue -u eCommonID/rc_training00` **You should only see one job running, on the "short" partition.**

* When the job is completed it will create a new directory with new files: What is the name of the new directory? How many new files and directories were created within it?

**Answer: The new directory is called `trimmed_fastq_SBATCH/`, and it has 18 files within it, no directories.**

* List only those files that end in `.zip`, 

**Answer:** `ls -l trimmed_fastq_SBATCH/*.zip`


### Exercise 2: "Quality trimming on 6 Fastq files, *in parallel* with multithreading"
* Check and make sure you have an interactive session going and also that you are in the `~/unix-intro/` directory.


**Answer:** `pwd` **and you should see `compute` before your command prompt**

* Use `nano` to open the `trimmomatic-multithreaded-slurm.sh` file and make note of the `sbatch` submission command in it. Name some of the SLURM/SBATCH options that we are requesting for each job in the loop.

**Answer:** `-p short -n 6 -t 0-2:00 --mem=2G --job-name trim-multithread -o %j.out -e %j.err --wrap`

* Run `trimmomatic-multithreaded-slurm.sh` using `sh` instead of `sbatch`.

**Answer:** `sh trimmomatic-multithreaded-slurm.sh`

* How many job submission notifications did you get?

**Answer: 6 jobs are submitted**

* Once submitted, immediately check the status of your jobs. How many are running and how many are pending?

**Answer:** `squeue -u eCommonsID` **The number running and pending will be variable depending on availability.**

Once again, when the job is complete a new directory with new files will be created. Use `ls -l` to determine if the same output was generated for both.
* What do you think the advantage is of running the job(s) this way as compared to Exercise 1?

**Answer: This set of scripts ran trimming on each fastq file one at a time in a multithreaded fashion, but ran them side-by-side (in parallel) for all 6 files as each sample was submitted as a separate job (pending status notwithstanding). Whereas the first script ran trimming in a multithreaded fashion also, but it ran it on the 6 files serially, one after the other.**

**The second exercise was more efficient since it used parallelization (each file had it's own job) and multithreading, instead of only multithreading (all files were run in a single job).**
