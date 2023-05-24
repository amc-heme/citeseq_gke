#!/bin/bash

CLUSTER_NAME="citeseq-cluster"
ZONE="us-central1-c"
MACHINE_TYPE="e2-highmem-4"
NETWORK="dev"
SUBNETWORK="sb-vpc-dev-common"
PROJECT="prj-dev-bio-sandbox"
BUCKET="bkt-test-926"

#Separate this into a third script
snakemake --kubernetes --use-conda --default-remote-provider GS --default-remote-prefix $BUCKET -j 999
