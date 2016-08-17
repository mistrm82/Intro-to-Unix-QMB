
# rename input file
infile=$1

# Create names for the output trimmed files
base=`basename $infile .subset.fq`
outfile=$base.qualtrim25.minlen35.fq

# Load modules
module load seq/Trimmomatic/0.33
module load seq/fastqc/0.11.3

# Create directory for trimmed files
mkdir -p ~/unix-intro/trimmed_fastq/


java -jar /opt/Trimmomatic-0.33/trimmomatic-0.33.jar SE \
  -threads 4 \
  -phred33 \
  $infile \
  ~/unix-intro/trimmed_fastq/$outfile \
  ILLUMINACLIP:/opt/Trimmomatic-0.33/adapters/TruSeq3-SE.fa:2:30:10 \
  TRAILING:25 \
  MINLEN:35

fastqc ~/unix-intro/trimmed_fastq/$outfile 
