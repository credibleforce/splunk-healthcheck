#!/bin/bash

if [ ! -d engagement_data ]; then
mkdir engagement_data
else
rm -rf engagement_data/*
fi

for s in $(grep -E "^\[.+]$" /opt/splunk/etc/apps/engagement_healthcheck/local/savedsearches.conf | sed 's/\[//g' | sed 's/\]//g'); do
echo "-------------------------------"
echo "Exporting: $s"
/opt/splunk/bin/splunk search "| savedsearch $s" -app engagement_healthcheck -maxout 0 -preview 0 -output json -earliest_time -24h -latest_time now> engagement_data/$s.json
echo "Complete."
done
echo "Creating archive of reports..."
tar -zcvf engagement_data.tgz engagement_data/
echo "Done. Please send engagement_data.tgz to PS Engineer"
