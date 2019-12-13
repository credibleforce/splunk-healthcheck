#!/usr/bin/env python3
import os, sys, io
import argparse
import glob
import re
import json
import html

script_dir = os.path.dirname(os.path.realpath(__file__))

# get args
parser = argparse.ArgumentParser(description="Create Engagment Report", add_help=True)
parser.add_argument("-c", "--customer", type=str, help="Customer name", required=True)
parser.add_argument("-d", "--data", type=str,
                    help="Import data directory", required=True)
parser.add_argument("-b", "--bundle", help="Bundle the data objects into the HTML page",
                    action='store_true', default=False, required=False)
args = parser.parse_args()

# set customer and data path
customer_name = args.customer
import_data_path = os.path.abspath(args.data)

print("Customer: {0}".format(customer_name))
print("Import Data Path: {0}".format(import_data_path))

# check for required output directory
if not os.path.exists(os.path.join(script_dir, "output")):
    os.mkdir(os.path.join(script_dir, "output"))

engagement_data_name = "{0}_engagement_data.js".format(re.sub(r"[^\w\s]", '', re.sub(r"\s+", '-', customer_name.lower())))
engagment_data_path = os.path.join(script_dir,"output",engagement_data_name)

# build a list of all report names
reports = []
report_files = glob.glob(os.path.join(import_data_path,"*.json"))
print("Report Files: {0}".format(report_files))

for r in report_files:
    reports.append(re.sub(r'\.json$','', os.path.basename(r)))

# load templates
f = open(os.path.join(script_dir, "templates/engagement_data_template.js"), "r")
engagement_data = f.read()

f = open(os.path.join(script_dir, "templates/bootstrapTable_template.js"), "r")
bootstrapTable = f.read()

f = open(os.path.join(script_dir, "templates/report_data_template.js"), "r")
report_data = f.read()

f = open(os.path.join(script_dir, "templates/index_template.html"), "r")
index = f.read()

f = open(os.path.join(script_dir, "templates/table_template.html"), "r")
table = f.read()

# build index and js data files
f_data = open(engagment_data_path, 'w+')
f_index = open(os.path.join(script_dir, "output", "index.html"), 'w+')

for r in reports:
    r_data = []
    print(os.path.join(import_data_path, "{0}.json".format(r)))
    with io.open(os.path.join(import_data_path, "{0}.json".format(r)), 'r') as f:
        for line in f:
            try:
                r_data.append(json.loads(line.encode('ascii', 'ignore')))
            except:
                continue

    # engagmenet data dynamic
    r_report_data = report_data
    r_report_data = r_report_data.replace('<<REPORT>>',r)
    r_report_data = r_report_data.replace('<<DATA>>',json.dumps(r_data))
    f_data.write(r_report_data + "\n")

f_data.close()

# index page dynamic build
index = index.replace('<<CUSTOMER_NAME>>', html.escape(customer_name))

# bundle the js with the HTML page
if args.bundle:
    with open(engagment_data_path, 'r') as f:
       data = f.read()
       index = index.replace('<<ENGAGEMENT_DATA>>',
                             "<script>{0}</script>".format(data))
    os.unlink(engagment_data_path)
else:
    index = index.replace('<<ENGAGEMENT_DATA>>', "<script src=\"{0}\"></script>".format(
        engagment_data_path.replace(script_dir, '.')))

f_index.write(index + "\n")
f_index.close()

print("done")
