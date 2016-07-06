#!/usr/bin/env python

import csv
import sys
from jinja2 import Environment, FileSystemLoader

input = str(sys.argv[1])

env = Environment(loader=FileSystemLoader('templates'))
template = env.get_template('cobbler_system.j2')

with open(input) as csvfile:
    reader = csv.DictReader(csvfile)
    reader.fieldnames = "hostname", "mac", "ip", "netmask", "gateway", "dns", "interface", "profile"

    for counter, row in enumerate(reader):
        hostname = str(row['hostname'])
        mac = str(row['mac'])
        ip = str(row['ip'])
        netmask = str(row['netmask'])
        gateway = str(row['gateway'])
        dns = str(row['dns'])
        interface = str(row['interface'])

        if row['profile'] is not None:
            profile = str(row['profile'])
        else:
            profile = "ubuntu-14.04.3-server-unattended-rpc"

        output = template.render(hostname=hostname, mac=mac, ip=ip, netmask=netmask, gateway=gateway, dns=dns, interface=interface, profile=profile)

        print output + "\n"
