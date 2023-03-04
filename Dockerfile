################# BASE IMAGE ######################
FROM --platform=linux/amd64 mambaorg/micromamba:1.3.1-focal
# Micromamba for fast building of small conda-based containers.
# https://github.com/mamba-org/micromamba-docker
# The 'base' conda environment is automatically activated when the image is running.

################## METADATA ######################
LABEL base_image="mambaorg/micromamba:1.3.1-focal"
LABEL version="1.0.0"
LABEL software="Bowtie 2"
LABEL software.version="2.5.1"
LABEL about.summary="Bowtie 2 is an ultrafast and memory-efficient tool for aligning sequencing reads to long reference sequences."
LABEL about.home="https://bowtie-bio.sourceforge.net/bowtie2/index.shtml"
LABEL about.documentation="https://bowtie-bio.sourceforge.net/bowtie2/manual.shtml"
LABEL about.license_file="https://github.com/BenLangmead/bowtie2/blob/master/LICENSE"
LABEL about.license="GNU GPL v3"

################## MAINTAINER ######################
MAINTAINER Matthew Galbraith <matthew.galbraith@cuanschutz.edu>

################## INSTALLATION ######################

# Copy the yaml file to your docker image and pass it to micromamba
COPY --chown=$MAMBA_USER:$MAMBA_USER env.yaml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes