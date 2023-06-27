#!/bin/bash

CLUSTER_NAME="citeseq-cluster"
ZONE="us-central1-c"
MACHINE_TYPE="e2-highmem-4"
NETWORK="projects/prj-dev-bio-sandbox/global/networks/dev"
SUBNETWORK="projects/prj-dev-bio-sandbox/regions/us-central1/subnetworks/sb-vpc-dev-common"
PROJECT="prj-dev-bio-sandbox"
BUCKET="bkt-test-926"
SERVICE_ACCOUNT="citeseq-pipeline-sa@prj-dev-bio-sandbox.iam.gserviceaccount.com"

# we need a delete script or a delete option here.
# will need to be tested 
gcloud container clusters delete $CLUSTER_NAME
