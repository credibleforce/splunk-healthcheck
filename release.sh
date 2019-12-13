#!/bin/bash

for arg in "$@"
do
    if [ "$arg" == "--help" ] || [ "$arg" == "-h" ]
    then
        echo "release.sh <GITHUB_TOKEN>"
        exit
    fi
done

if [ -z "$1" ]
then
	echo "Missing GITHUB_TOKEN"
	exit
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

VERSION=$(cat version.txt)
export GITHUB_TOKEN=$1

$DIR/splunk_app/build.sh
$DIR/report_builder/build.sh
$DIR/engagement_export/build.sh

githubrelease release scalatar/splunk-engagement-healthcheck create $VERSION --prerelease
githubrelease asset scalatar/splunk-engagement-healthcheck upload $VERSION $DIR/splunk_app/dist/*.tgz
githubrelease asset scalatar/splunk-engagement-healthcheck upload $VERSION $DIR/report_builder/dist/*.tgz
githubrelease asset scalatar/splunk-engagement-healthcheck upload $VERSION $DIR/engagement_export/dist/*.zip
githubrelease release scalatar/splunk-engagement-healthcheck publish $VERSION
