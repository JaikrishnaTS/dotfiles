#!/bin/bash

dev_reg=${1?Must provide device name regex}
dev_name=`xinput list --name-only | sed -n "/${dev_reg}/p"`

echo "Device name: ${dev_name}"
if [[ -z ${dev_name} ]]; then
    echo "Unable to find device with given regex"
    exit 1
fi

is_enabled=`xinput list-props "${dev_name}" | 
    sed -n 's/^\s\+Device Enabled ([0-9]\+):\s\+\([0,1]\)$/\1/p'`

if [[ ${is_enabled} -eq 1 ]]; then
    echo "Disabled";
    xinput disable "${dev_name}";
else
    echo "Enabled";
    xinput enable "${dev_name}";
fi

