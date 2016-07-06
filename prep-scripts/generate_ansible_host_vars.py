#!/usr/bin/env python

from netaddr import *
import csv
import sys
from jinja2 import Environment, FileSystemLoader

input = str(sys.argv[1])

env = Environment(loader=FileSystemLoader('templates'))
template = env.get_template('host_vars.j2')

mgmt_ip_list = list(iter_iprange('172.29.236.51', '172.29.236.254'))

storage_ip_list = list(iter_iprange('172.29.244.51', '172.29.244.254'))

vxlan_ip_list = list(iter_iprange('172.29.240.51', '172.29.240.254'))

swift_ip_list = list(iter_iprange('172.29.248.51', '172.29.248.254'))

with open(input) as csvfile:
    reader = csv.DictReader(csvfile)
    reader.fieldnames = "hostname", "mac", "host_ip"

    for counter, row in enumerate(reader):
        hostname = str(row['hostname'])
        host_ip = str(row['host_ip'])
        mgmt_ip = str(mgmt_ip_list[counter])
        storage_ip = str(storage_ip_list[counter])
        vxlan_ip = str(vxlan_ip_list[counter])
        swift_ip = str(swift_ip_list[counter])

        output = template.render(mgmt_ip=mgmt_ip, storage_ip=storage_ip, vxlan_ip=vxlan_ip, swift_ip=swift_ip, host_ip=host_ip)

        with open("host_vars/%s" % hostname, 'w') as outputfile:
            outputfile.write(output)