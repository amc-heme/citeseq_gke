#!/bin/sh -l

#echo "Hello $1"
#echo "account_email=$1" >> $GITHUB_OUTPUT
echo "PWD $PWD" 
echo "GITHUB_WORKSPACE $GITHUB_WORKSPACE"
echo "ls:" 
ls $GITHUB_WORKSPACE
time=$(date)
echo "time=$time" >> $GITHUB_OUTPUT


mkdir -p /github/workspace/.conda


#Complete this for Github custom action
SERVICE_ACCOUNT_KEY=$1
echo $SERVICE_ACCOUNT_KEY > $GITHUB_WORKSPACE/service_account_key.json
GOOGLE_APPLICATION_CREDENTIALS=$GITHUB_WORKSPACE/service_account_key.json

#echo "SERVICE_ACCOUNT_KEY: $SERVICE_ACCOUNT_KEY" 

/root/google-cloud-sdk/bin/gcloud auth activate-service-account --key-file=$GITHUB_WORKSPACE/service_account_key.json
