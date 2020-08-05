#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

if [ ! -d "$DIR/dist" ]; then
        echo "Creating dist directory..."
        mkdir -p "$DIR/dist"
fi

VERSION=$(cat version.txt)

rm -f app.conf dist/engagement_healthcheck.tgz 2>/dev/null
awk -v ver=$VERSION '{ gsub(/[0-9]+\.[0-9]+\.[0-9]+/,ver); print }' engagement_healthcheck/local/app.conf > app.conf
mv app.conf engagement_healthcheck/local/app.conf
tar -zcvf dist/engagement_healthcheck.tgz engagement_healthcheck
