# Terraform OCI Always Free OKE - Private Cluster Example

This example demonstrates how to use the terraform-oci-always-free-oke module to create a private Kubernetes cluster within Oracle Cloud. This configuration is based on the Oracle Container Engine for Kubernetes (OKE) in Oracle Cloud Infrastructure (OCI) which is always free to use.


## Prerequisites
To use this example, you will need:
* An Oracle Cloud Infrastructure account
* Terraform v1.2.0 or later

## Installation and Setup
This section provides a step-by-step guide on how to set up and use this example with Terraform CLI to create a private Kubernetes cluster.

### 1. Clone this repository:

```bash
git clone https://github.com/ystory/terraform-oci-always-free-oke.git
cd terraform-oci-always-free-oke/examples/private-cluster
```

### 2. Configure Terraform variables:
* Create a copy of the example variable file by renaming terraform.tfvars.example to terraform.tfvars:

```
cp terraform.tfvars.example terraform.tfvars
```

* Input the necessary values in the `terraform.tfvars` file:

```hcl
# Identity and access parameters
user_id = ""
api_fingerprint = ""
api_private_key_path = ""
# api_private_key      = <<EOT
#-----BEGIN RSA PRIVATE KEY-----
#content+of+api+key
#-----END RSA PRIVATE KEY-----
#EOT
tenancy_id = ""
region = ""
home_region = ""

# SSH keys
# ssh_private_key    = <<EOT
#-----BEGIN RSA PRIVATE KEY-----
#content+of+api+key
#-----END RSA PRIVATE KEY-----
#EOT
ssh_private_key_path = ""
# ssh_public_key    = ""
ssh_public_key_path  = ""

# oke cluster options
kubernetes_version = ""
node_pool_size = 2

# general oci parameters
label_prefix = "dev"
```

#### Note: You must provide exactly 2 region entries:
* home_region: Specifies your tenancy's home region, which may not be the same as the region where you want to create the OKE cluster.
* region: Indicates the actual region where you want to deploy the OKE cluster.

For the list of available regions, please refer to [here](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm).


### 3. Execute Terraform

```bash
terraform init
terraform plan
terraform apply
```
