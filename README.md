[![Docker Image CI](https://github.com/mattgalbraith/bowtie2-docker-singularity/actions/workflows/docker-image.yml/badge.svg)](https://github.com/mattgalbraith/bowtie2-docker-singularity/actions/workflows/docker-image.yml)

# bowtie2-docker-singularity

## Build Docker container for Bowtie 2 and (optionally) convert to Apptainer/Singularity.  

Bowtie 2 is an ultrafast and memory-efficient tool for aligning sequencing reads to long reference sequences.  
https://bowtie-bio.sourceforge.net/bowtie2/index.shtml  
  
#### Requirements:
see https://bioconda.github.io/recipes/bowtie2/README.html  
Install within image using micromamba  
https://github.com/mamba-org/micromamba-docker  
  
## Build docker container:  

### 1. For Bowtie 2 installation instructions:  
https://bowtie-bio.sourceforge.net/bowtie2/manual.shtml#obtaining-bowtie-2  


### 2. Build the Docker Image

#### To build image from the command line:  
``` bash
# Assumes current working directory is the top-level bowtie2-docker-singularity directory
docker build -t bowtie:2.5.1 . # tag should match software version
```
* Can do this on [Google shell](https://shell.cloud.google.com)

#### To test this tool from the command line:
``` bash
docker run --rm -it bowtie:2.5.1 bowtie2 --help 
```

## Optional: Conversion of Docker image to Singularity  

### 3. Build a Docker image to run Singularity  
(skip if this image is already on your system)  
https://github.com/mattgalbraith/singularity-docker

### 4. Save Docker image as tar and convert to sif (using singularity run from Docker container)  
``` bash
docker images
docker save <Image_ID> -o bowtie2.5.1-docker.tar && gzip bowtie2.5.1-docker.tar # = IMAGE_ID of Bowtie2 image
docker run -v "$PWD":/data --rm -it singularity:1.1.5 bash -c "singularity build /data/bowtie2.5.1-docker.sif docker-archive:///data/bowtie2.5.1-docker.tar.gz"
```
NB: On Apple M1/M2 machines ensure Singularity image is built with x86_64 architecture or sif may get built with arm64  

Next, transfer the bowtie2.5.1-docker.sif file to the system on which you want to run Bowtie 2 from the Singularity container  

### 5. Test singularity container on (HPC) system with Singularity/Apptainer available  
``` bash
# set up path to the Singularity container
BOWTIE2_SIF=path/to/bowtie2.5.1-docker.sif

# Test that Bowtie 2 can run from Singularity container
singularity run $BOWTIE2_SIF bowtie2 --help # depending on system/version, singularity may be called apptainer
```