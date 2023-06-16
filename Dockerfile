FROM snakemake/snakemake 

RUN apt-get update 

WORKDIR /root/

RUN curl -sSL https://sdk.cloud.google.com > /tmp/gcl && bash /tmp/gcl --disable-prompts

#export PATH=$PATH:/root/google-cloud-sdk/bin/
ENV PATH $PATH:/root/google-cloud-sdk/bin 

RUN gcloud components install kubectl --quiet

RUN pip install kubernetes 

RUN git clone https://github.com/amc-heme/citeseq_gke.git

#This will be replaced with the secrets file reference
#COPY citeseq-SA-key.json /root/citeseq-SA-key.json 

#ENV GOOGLE_APPLICATION_CREDENTIALS /root/citeseq-SA-key.json 

#RUN gcloud auth activate-service-account --key-file=/root/citeseq-SA-key.json 

WORKDIR /root/citeseq_gke/

RUN snakecharmer_lean.sh

### Notes
# Reference https://insights.project-a.com/using-github-actions-to-deploy-to-kubernetes-in-gke/ 
###