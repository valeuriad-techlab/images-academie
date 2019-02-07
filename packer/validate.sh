#!/bin/bash

PATH=$PATH:.

KSVALIDATOR_PATH=$(which ksvalidator 2>&1 1>/dev/null)
KSVALIDATOR_EXISTS=$?

if [ "$KSVALIDATOR_EXISTS" -eq 0 ]
then
    >&2 printf "[INFO] Validation KickStart de anaconda-ks.cfg\n"
    ksvalidator -i "anaconda-ks.cfg"
else
    >&2 printf "[WARN] La commande ksvalidator n'est pas disponible...\n"
fi

PACKER_PATH=$(which packer 2>&1 1>/dev/null)
PACKER_EXISTS=$?

if [ "$PACKER_EXISTS" -eq 0 ]
then
    >&2 printf "[INFO] Validation Packer de CentOS-7-x86_64.json\n"
    packer validate "CentOS-7-x86_64.json"
else
    >&2 printf "[FATAL] La commande packer n'est pas disponible...\n"
    exit 1
fi
