#!/bin/bash

for tar in $(find target/images -type f); do
    echo ">> importing ${tar}..." 
    sudo ctr --debug --namespace=k8s.io images import  --all-platforms --no-unpack ${tar}
done

sudo sudo ctr images ls