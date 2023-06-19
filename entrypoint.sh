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
printf '%s' "$1" > $GITHUB_WORKSPACE/service_account_key.json
/root/google-cloud-sdk/bin/gcloud auth activate-service-account --key-file=$GITHUB_WORKSPACE/service_account_key.json

