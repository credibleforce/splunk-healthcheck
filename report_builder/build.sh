#!/bin/bash

VERSION=$(cat version.txt)

tar -zcvf dist/report_builder.$VERSION.tgz report_builder.py engagement_data templates