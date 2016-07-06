#!/usr/bin/env python

import csv
import sys

input = str(sys.argv[1])

with open(input) as csvfile:
    reader = csv.DictReader(csvfile)
    reader.fieldnames = "hostname", "mac", "ip"
    output = ""
    for row in reader:
        output += row['hostname'] + " ansible_ssh_host=" + row['ip'] + "\n"

print output