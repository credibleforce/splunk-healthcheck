#!/usr/bin/env python3

import sys

import xml.etree.ElementTree as ET
root = ET.parse('deployment.xml').getroot()
tree = ET.ElementTree(root)

for panels in tree.findall('row/panel'):
	title = panels.find('title')
	search = panels.find('*/search')
	if search != None and title != None:
		title = title.text.replace(" - ","").replace(" ","_").lower()
		for child in search.findall("query"):
			search.remove(child)
		search.set("ref",title)


tree.write(sys.stdout, encoding='unicode')
