# Oracle Cloud Always Free Kubernetes Cluster

A Terraform module to effortlessly create and manage a Kubernetes cluster within Oracle Cloud's Always Free Resources tier, enabling users to leverage Kubernetes without incurring additional costs.

The following resources will be created:
* Compartment
* Virtual Cloud Network (VCN) for Kubernetes with Internet, NAT and Service Gateways
* Control-plane subnet and security group
* Subnets and security groups for internal and public load balancers
* Subnets and security groups for worker nodes
* Bastion service
* Kubernetes cluster and a single node pool consisting of always-free ARM-based Ampere A1 compute instances

## Prerequisites
1. git is installed
2. SSH client is installed
3. Terraform is installed
4. jq is installed

## Configure Terraform Variables
* Make a copy of the example variable file by renaming terraform.tfvars.example to terraform.tfvars:

```
cp terraform.tfvars.example terraform.tfvars
```

* Provide the necessary values in the terraform.tfvars file:

## Execute Terraform

```
terraform init
terraform plan
terraform apply
```
