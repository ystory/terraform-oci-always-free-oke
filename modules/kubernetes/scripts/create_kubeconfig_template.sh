#!/bin/bash

# Create the kubeconfig file
oci ce cluster create-kubeconfig \
  --cluster-id ${cluster_id} \
  --file ~/.kube/ociconfig \
  --region ${region} \
  --token-version 2.0.0 \
  --overwrite \
  --kube-endpoint PRIVATE_ENDPOINT

# The command below updates the Kubernetes config to use a bastion tunnel for accessing the cluster's private IP.
perl -i -pe's/${cluster_ip}/127.0.0.1/g' ~/.kube/ociconfig
