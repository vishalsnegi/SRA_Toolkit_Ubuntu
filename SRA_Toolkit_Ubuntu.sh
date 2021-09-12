
## ############################################################### ##
## --------------------------------------------------------------- ##
## SRA Toolkit for Ubuntu in Windows Subsystem for Linux (WSL)
## --------------------------------------------------------------- ##
## ############################################################### ##

## --------------------------------------- ## 
##       Set working directory
## --------------------------------------- ##

## In Windows Subsystem for Linux (WSL) The C:\ drive is mounted as /mnt/c/, 
## E:\ is mounted as /mnt/e/ et cetra. Therefore, E:/Linux should be at /mnt/e/Linux.

cd /mnt/e/Linux

## Create Folder SRA
mkdir  SRA
cd SRA

## Fetch the tar file from the canonical location at NCBI
wget --output-document sratoolkit.tar.gz http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz

## Extract the contents of the tar file:
tar -vxzf sratoolkit.tar.gz
## Check if installed
ls 

## For convenience (and to show you where the binaries are) append the path to the binaries to your PATH environment variable:
export PATH=$PATH:$PWD/sratoolkit.2.11.1-ubuntu64/bin

##  Verify that the binaries will be found by the shell:
which fastq-dump
which fasterq-dump

## --------------------------------------- ## 
##       Toolkit Configuration
## --------------------------------------- ##

## If you are using SRA Toolkit version 2.4 or higher, 
## you should run the configuration tool located within the bin subdirectory of the Toolkit package.

## Go to the "bin" subdirectory for the Toolkit and run the following command line:

cd /mnt/e/Linux/SRA/sratoolkit.2.11.1-ubuntu64/bin
./vdb-config -i

## Proceed to the Quick Configuration of SRA Toolkit
## Visit https://github.com/ncbi/sra-tools/wiki/03.-Quick-Toolkit-Configuration
vdb-config -i

## Follow the instructions given in https://github.com/ncbi/sra-tools/wiki/05.-Toolkit-Configuration

## When we run vdb-config in interactive or command line modes, we will be 
## editing a user-local configuration. There are a large number of variables, 
## most of which are only available at this time from command line mode.
## To set a value such as the HTTP read timeout:

# set timeout to 10 seconds
vdb-config -s /http/timeout/read=10000

## Test that the toolkit is functional:
fastq-dump --stdout SRR390728 | head -n 8

## --------------------------------------- ## 
##       prefetch and fasterq dump
## --------------------------------------- ##

## The combination of prefetch + fasterq-dump is the fastest way to extract FASTQ-files
## from SRA-accessions. The prefetch tool downloads all necessary files to your computer. 
## The prefetch - tool can be invoked multiple times if the download did not succeed. 
## It will not start from the beginning every time; instead, it will pick up from where 
## the last invocation failed.

## The prefetch-tool downloads to a directory named by accession. 
## E.g. prefetch SRR000001 will create a directory named SRR000001 in the current directory. 
## Make sure that if you move the SRR000001 directory, you don't rename it 
## as the conversion-tool will need to find the original directory.

## To ask prefetch save the downloaded files in the current working directory 
vdb-config --prefetch-to-cwd

###### Extract fastq-file(s) from SRA - accessions ######
## Estimating space requirements
vdb-dump --info SRR13764788

## --------------------------------------- ## 
##       Downloading data from SRA
## --------------------------------------- ##

## You can download SRA fastq files using the fasterq-dump tool, which will download the fastq file 
## into your current working directory by default. (Note: the old fastq-dump is being deprecated). 
## During the download, a temporary directory will be created in the location specified by the -t flag
## (in the example below, in /scratch/$USER) that will get deleted after the download is complete.

fasterq-dump SRR13764788

## --------------------------------------- ## 
##           REFERENCE(S)
## --------------------------------------- ##

## https://github.com/ncbi/sra-tools/wiki

## ----------      END       ------------  ## 