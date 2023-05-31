# terraform-oci-always-free-oke

A Terraform module to effortlessly create and manage a Kubernetes cluster within Oracle Cloud's Always Free Resources
tier, enabling users to leverage Kubernetes without incurring additional costs.

## Examples

```hcl
module "free-k8s" {
  source = "ystory/always-free-oke/oci"
  #  version = "x.x.x"

  tenancy_id  = var.tenancy_id
  home_region = var.home_region
  region      = var.region

  node_pool_size = 2

  ssh_private_key_path = "~/.ssh/id_rsa"
  ssh_public_key_path  = "~/.ssh/id_rsa.pub"

  providers = {
    oci.home = oci.home
  }
}
```

## Requirements

| Name      | Version    |
|-----------|------------|
| terraform | >= 1.2.0   |
| oci       | >= 4.122.0 |

## Providers

| Name | Version    |
|------|------------|
| oci  | >= 4.122.0 |

## Modules

| Name | Source                          | Version |
|------|---------------------------------|---------|
| oke  | oracle-terraform-module/oke/oci | 4.5.9   |

## Resources

The following resources will be created:

* Compartment
* Virtual Cloud Network (VCN) for Kubernetes with Internet, NAT and Service Gateways
* Control-plane subnet and security group
* Subnets and security groups for internal and public load balancers
* Subnets and security groups for worker nodes
* Bastion service
* Kubernetes cluster and a single node pool consisting of always-free ARM-based Ampere A1 compute instances
