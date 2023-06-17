FROM snakemake/snakemake 

#Set env variables
ENV PATH $PATH:/github/workspace/google-cloud-sdk/bin 
ENV CONDA_ENVS_PATH /github/workspace/.conda

RUN apt-get update 
#get google cloud sdk
RUN curl -sSL https://sdk.cloud.google.com > /tmp/gcl && bash /tmp/gcl --disable-prompts

#Kubernetes components required
RUN ~/google-cloud-sdk/bin/gcloud components install kubectl --quiet
RUN pip install kubernetes 

RUN ls -alh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["entrypoint.sh"]