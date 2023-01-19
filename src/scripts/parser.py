#!/usr/bin/python3

import sys
import quopri
import re

mailFile = sys.argv[1]

try:
	with open(mailFile, 'rb') as fp:
		mail = fp.read().decode('utf-8')

	matches = re.search(r"<!DOCTYPE(.|\s)*<\/html>", mail, re.MULTILINE | re.UNICODE)
	temp = quopri.decodestring(matches.group())
	html = temp.decode("utf-8", "strict")
except UnicodeDecodeError as error:
	with open(mailFile, 'rb') as fp:
		mail = fp.read().decode('cp1252')

	matches = re.search(r"<!DOCTYPE(.|\s)*<\/html>", mail, re.MULTILINE | re.UNICODE)
	temp = quopri.decodestring(matches.group())
	html = temp.decode("cp1252", "strict")

htmlFile = open(mailFile + ".html", "w")
htmlFile.write(html)
htmlFile.close()
