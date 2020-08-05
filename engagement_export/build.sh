#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

if [ ! -d "$DIR/dist" ]; then
        echo "Creating dist directory..."
        mkdir -p "$DIR/dist"
fi

VERSION=$(cat splunk_engagement_export/version.txt)

rm -f dist/engagement_export.zip
rm -f splunk_engagement_export/engagement_data/*
zip -r dist/engagement_export.zip splunk_engagement_export
