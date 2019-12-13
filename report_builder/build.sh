#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

VERSION=$(cat report_builder/version.txt)

rm -f dist/report_builder.tgz
tar -zcvf dist/report_builder.tgz report_builder