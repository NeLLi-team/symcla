FROM --platform=linux/amd64 condaforge/mambaforge:24.3.0-0

LABEL maintainer="jvillada@lbl.gov"
LABEL version="v0.1"
LABEL software="symcla: symbiont classifier"

WORKDIR /usr/src/
ADD symcla /usr/src/symcla/

ADD data/feature_annotation_majority_for_symcla.tsv /usr/src/symcla/data/
ADD data/hmms_symcla /usr/src/symcla/data/hmms_symcla/
ADD data/hmms_uni56 /usr/src/symcla/data/hmms_uni56/
ADD data/ml_models /usr/src/symcla/data/ml_models/

ADD requirements.txt /usr/src/symcla/
RUN chmod +x /usr/src/symcla

RUN mamba install -c bioconda --file /usr/src/symcla/requirements.txt -y
RUN mamba clean --all

ENV PATH=${PATH}:/usr/src/symcla

WORKDIR /usr/src/symcla

RUN rm requirements.txt