#!/bin/bash

VERSION=$(cat version.txt)

zip -r build/engagement_report.$VERSION.zip splunk_engagement_export