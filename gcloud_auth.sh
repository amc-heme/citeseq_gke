#!/bin/bash

CLUSTER_NAME="test-cluster-small"
ZONE="us-central1-c"
MACHINE_TYPE="e2-highmem-4"
NETWORK="dev"
SUBNETWORK="sb-vpc-dev-common"
PROJECT="prj-dev-bio-sandbox"
BUCKET="bkt-test-926"

#authenticates so the service account can use the bucket
#This is not needed since we don't 
#gcloud auth application-default login

#gives the cluster the appropriate credentials
gcloud container clusters get-credentials --zone=$ZONE --project $PROJECT $CLUSTER_NAME


#Separate this into a third script
#snakemake --kubernetes --use-conda --default-remote-provider GS --default-remote-prefix $BUCKET -j 999
