#!/bin/bash

for arg in "$@"
do
    if [ "$arg" == "--help" ] || [ "$arg" == "-h" ]
    then
        echo "release.sh <GITHUB_TOKEN> <VERSION>"
        exit
    fi
done

if [ -z "$1" ]
then
	echo "Missing GITHUB_TOKEN"
	exit
fi

if [ -z "$2" ]
then
	echo "Missing VERSION"
	exit
fi

GITHUB_TOKEN=$1
VERSION=$2

githubrelease release scalatar/splunk-engagement-healthcheck create $VERSION --prerelease
githubrelease asset scalatar/splunk-engagement-healthcheck upload $VERSION splunk_app/dist/*
githubrelease asset scalatar/splunk-engagement-healthcheck upload $VERSION report_builder/dist/*
githubrelease asset scalatar/splunk-engagement-healthcheck upload $VERSION engagement_export/dist/*
githubrelease release scalatar/splunk-engagement-healthcheck publish $VERSION
