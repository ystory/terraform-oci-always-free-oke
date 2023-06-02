#!/bin/bash

# Create the kubeconfig file
oci ce cluster create-kubeconfig \
  --cluster-id ${cluster_id} \
  --file ~/.kube/ociconfig \
  --region ${region} \
  --token-version 2.0.0 \
  --overwrite \
  --kube-endpoint PRIVATE_ENDPOINT

# Change the cluster IP to 127.0.0.1
sed -i '' "s/${cluster_ip}/127.0.0.1/g" ~/.kube/ociconfig
