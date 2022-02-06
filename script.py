#!/usr/bin/env python3

import socket
import time
import json
import yaml

srv = {'drive.google.com':'', 'mail.google.com':'', 'google.com':''}

print('start script')

while True:
    for host in srv:
        ip = socket.gethostbyname(host)
        if ip != srv[host] :
            if srv[host] != '' :
                print(f'[ERROR] {host} IP mismatch: {srv[host]} {ip}') 
            srv[host] = ip
        with open('services.yaml', 'w') as yml:
            yml.write(yaml.dump(srv, indent=2, explicit_end=True, explicit_start=True))
        with open('services.json', 'w') as js:
            js.write(json.dumps(srv, indent=2))
    time.sleep(2)