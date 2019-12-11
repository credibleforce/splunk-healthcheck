#!/bin/bash

VERSION=$(cat version.txt)

zip -r dist/engagement_report.$VERSION.zip splunk_engagement_export