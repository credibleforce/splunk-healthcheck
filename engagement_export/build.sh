#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

VERSION=$(cat splunk_engagement_export/version.txt)

rm -f dist/engagement_export.zip
zip -r dist/engagement_export.zip splunk_engagement_export