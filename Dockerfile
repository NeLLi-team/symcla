FROM --platform=linux/amd64 ubuntu:23.10

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y build-essential wget libncurses5-dev zlib1g-dev libbz2-dev liblzma-dev libcurl3-dev curl tar git
RUN apt-get clean
RUN apt-get purge
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr/src

# Copy the entire symcla folder into the container
COPY . /usr/src/symcla

# Make the symcla executable
RUN chmod +x /usr/src/symcla

# Add the symcla repo to the path
ENV PATH=${PATH}:/usr/src/symcla


# Install Mamabaforge:
RUN wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh && \
    bash Mambaforge-Linux-x86_64.sh -b -p /usr/src/mambaforge && \
    rm Mambaforge-Linux-x86_64.sh

# Add mambaforge to the path
ENV PATH=${PATH}:/usr/src/mambaforge/bin

# Install mamba packages using the requirements file, make sure yes is seleted
RUN mamba install -c bioconda --file /usr/src/symcla/requirements.txt -y

# Setup symcla
WORKDIR /usr/src/symcla
RUN symcla setup