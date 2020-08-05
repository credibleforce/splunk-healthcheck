#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

if [ ! -d "$DIR/dist" ]; then
        echo "Creating dist directory..."
        mkdir -p "$DIR/dist"
fi

VERSION=$(cat report_builder/version.txt)

rm -f dist/report_builder.tgz
rm -f report_builder/output/*
tar -zcvf dist/report_builder.tgz report_builder
