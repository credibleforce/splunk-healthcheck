#!/bin/bash

VERSION=$(cat version.txt)

rm app.conf 2>/dev/null
awk -v ver=$VERSION '{ gsub(/[0-9]+\.[0-9]+\.[0-9]+/,ver); print }' engagement_healthcheck/local/app.conf > app.conf
mv app.conf engagement_healthcheck/local/app.conf
tar -zcvf build/engagement_healthcheck_$VERSION.tgz engagement_healthcheck
