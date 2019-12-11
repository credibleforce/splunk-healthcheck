#!/usr/bin/env python3

import xml.etree.ElementTree as ET
root = ET.parse('deployment.xml').getroot()


for panels in root.findall('row/panel'):
	#value = type_tag.get('foobar')
	#print(value)
	title = panels.find('title')
	query = panels.find('*/search/query')
	if query != None and title != None:
		title = title.text.replace(" - ","").replace(" ","_").lower()
		query = query.text.replace("\n"," \\\n")
		print("["+title+"]")
		print("search = " + query)
		print()
