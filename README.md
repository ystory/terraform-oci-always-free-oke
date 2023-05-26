# Oracle Cloud Free Tier Kubernetes Cluster Deployment using Terraform

This Terraform configuration deploys a fully functional and scalable Kubernetes cluster on Oracle Cloud Free Tier.

The following resources will be created:
* Compartment
* Virtual Cloud Network (VCN) for Kubernetes with Internet, NAT and Service Gateways
* Control-plane subnet and security group
* Subnets and security groups for internal and public load balancers
* Subnets and security groups for worker nodes
* Bastion service
* Kubernetes cluster and a single node pool consisting of always-free ARM-based Ampere A1 compute instances
* Kubeconfig file for accessing the cluster using kubectl
* Ingress-Nginx Controller installation and provisioning on Kubernetes with OCI Flexible Load Balancer

## Assumptions
1. Ensure you have set up the [necessary API signing keys](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm)
2. Make sure you know the [required OCIDs](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm#five)
3. Verify that you have configured the [appropriate OKE policies](https://docs.cloud.oracle.com/iaas/Content/ContEng/Concepts/contengpolicyconfig.htm#PolicyPrerequisitesService)

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

```
ssh_private_key_path = <path to private key>
ssh_public_key_path  = <path to public key>

home_region  = <home region>
region       = <region>
tenancy_ocid = <tenancy ocid>

label_prefix = <label prefix>
```

## Execute Terraform

```
terraform init
terraform plan
terraform apply
```

## Accessing Private OKE Kubernetes Clusters using OCI Bastion Service

To access private OKE Kubernetes clusters using OCI Bastion Service, you can execute the `terraform apply` command with the `-target` and `-var` options as follows:

```
terraform apply -target=null_resource.bastion_tunnel -var="always_run_bastion_tunnel=true"
```

This command will ensure that the `null_resource.bastion_tunnel` is always triggered, allowing you to connect to the private OKE Kubernetes cluster using the OCI Bastion Service, or create a new SSH tunnel if needed.


To verify that your connection is working correctly, you can execute the following `kubectl` command:

```
kubectl --kubeconfig ~/.kube/ociconfig cluster-info
```
