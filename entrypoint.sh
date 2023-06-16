#!/bin/sh -l

echo "Hello $1"
echo "account_email=$1" >> $GITHUB_OUTPUT
