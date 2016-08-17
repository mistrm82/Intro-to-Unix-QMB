
#! /bin/bash

for fastq in ~/unix-intro/raw_fastq/*fq
do
bsub -q priority -n 4 -W 0:30 -R "rusage[mem=2000]" -J trim-multithread -o %J.out -e %J.err sh trimmomatic-on-input-file.sh $fastq
done
exit
