#!/bin/bash

VERSION=$(cat version.txt)

zip -r dist/engagement_export.$VERSION.zip splunk_engagement_export