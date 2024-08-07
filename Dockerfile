FROM --platform=linux/amd64 condaforge/mambaforge:24.3.0-0

LABEL maintainer="jvillada@lbl.gov"
LABEL version="v0.1"
LABEL software="symcla: symbiont classifier"

ADD symcla /usr/src/symcla/
ADD data /usr/src/symcla/data
ADD requirements.txt /usr/src/symcla/requirements.txt

RUN mamba install -c bioconda --file /usr/src/symcla/requirements.txt -y
# RUN mamba update python
# RUN mamba update --all
# RUN mamba install -c bioconda hmmer numpy pandas scikit-learn shap typer xgboost
RUN mamba clean --all

ENV PATH=${PATH}:/usr/src/symcla
WORKDIR /usr/src/symcla/