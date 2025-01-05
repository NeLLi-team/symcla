FROM condaforge/mambaforge:24.3.0-0

LABEL maintainer="jvillada@lbl.gov"
LABEL version="v0.1"
LABEL software="symcla: symbiont classifier"

ADD symcla /usr/src/symcla/
# decompress data_v1.tar.gz and ADD the resultin "data" folder to /usr/src/symcla/data
CMD tar -xvf /usr/src/symcla/data_v1.tar.gz -C /usr/src/symcla/
# ADD data /usr/src/symcla/data
ADD requirements.txt /usr/src/symcla/requirements.txt

RUN mamba install -c bioconda --file /usr/src/symcla/requirements.txt -y
RUN mamba clean --all

ENV PATH=${PATH}:/usr/src/symcla
WORKDIR /usr/src/symcla/
