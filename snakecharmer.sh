#!/bin/bash

CLUSTER_NAME="citeseq-cluster"
ZONE="us-central1-c"
MACHINE_TYPE="e2-highmem-4"
NETWORK="projects/prj-dev-bio-sandbox/global/networks/dev"
SUBNETWORK="projects/prj-dev-bio-sandbox/regions/us-central1/subnetworks/sb-vpc-dev-common"
PROJECT="prj-dev-bio-sandbox"
BUCKET="bkt-test-926"
SERVICE_ACCOUNT="citeseq-pipeline-sa@prj-dev-bio-sandbox.iam.gserviceaccount.com"

#copied from the snakemake action
mkdir -p /github/workspace/.conda

#Complete this for Github custom action
#printf '%s' "$1" > $GITHUB_WORKSPACE/service_account_key.json
#gcloud auth activate-service-account --key-file=$GITHUB_WORKSPACE/service_account_key.json
#export GOOGLE_APPLICATION_CREDENTIALS=$GITHUB_WORKSPACE/service_account_key.json

#Add git exception for github action
git config --global --add safe.directory /github/workspace

gcloud container clusters create $CLUSTER_NAME \
    --zone=$ZONE \
    --num-nodes=1 \
    --machine-type=$MACHINE_TYPE \
    --scopes storage-rw \
    --disk-size=200GB \
    --max-nodes=2 \
    --min-nodes=0 \
    --enable-autoscaling \
    --network=$NETWORK \
    --subnetwork=$SUBNETWORK \
    --service-account $SERVICE_ACCOUNT \
    --project $PROJECT
    
#gives the cluster the appropriate credentials
gcloud container clusters get-credentials --zone=$ZONE --project $PROJECT $CLUSTER_NAME

#Run the pipeline
snakemake --kubernetes --use-conda --default-remote-provider GS --default-remote-prefix $BUCKET -j 999

#bye bye cluster!
gcloud container clusters delete --zone=$ZONE --project $PROJECT --quiet $CLUSTER_NAME
