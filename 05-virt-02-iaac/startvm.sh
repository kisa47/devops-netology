#!/bin/bash
cd vagrant && test -f ./libvirt.box || wget -O ./libvirt.box https://app.vagrantup.com/debian/boxes/bullseye64/versions/11.20220328.1/providers/libvirt.box && vagrant box add debian-bullseye ./libvirt.box || echo "vagrant box already added"
