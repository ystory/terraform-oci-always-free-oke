variable "name" {
  default     = "free-k8s"
  description = "The name to be used for the OKE cluster and compartment during creation."
  type        = string
}

# OCI Provider parameters
variable "home_region" {
  # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
  description = "The tenancy's home region. Required to perform identity operations."
  type        = string
}

variable "region" {
  # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
  description = "The OCI region where OKE resources will be created."
  type        = string
}

variable "tenancy_id" {
  description = "The tenancy id of the OCI Cloud Account in which to create the resources."
  type        = string
}

variable "label_prefix" {
  default     = "none"
  description = "A string that will be prepended to all resources."
  type        = string
}

# SSH keys
variable "ssh_private_key" {
  default     = ""
  description = "The contents of the private ssh key file, optionally base64-encoded."
  sensitive   = true
  type        = string
}

variable "ssh_private_key_path" {
  default     = "none"
  description = "The path to ssh private key."
  type        = string
}

variable "ssh_public_key" {
  default     = ""
  description = "The contents of the ssh public key."
  type        = string
}

variable "ssh_public_key_path" {
  default     = "none"
  description = "The path to ssh public key."
  type        = string
}

# Kubernetes cluster
variable "kubernetes_version" {
  default     = "v1.24.1"
  description = "The version of kubernetes to use when provisioning OKE or to upgrade an existing OKE cluster to."
  type        = string
}

variable "control_plane_type" {
  default     = "public"
  description = "Whether to allow public or private access to the control plane endpoint"
  type        = string

  validation {
    condition     = contains(["public", "private"], var.control_plane_type)
    error_message = "Accepted values are public, or private."
  }
}

variable "control_plane_allowed_cidrs" {
  default     = []
  description = "The list of CIDR blocks from which the control plane can be accessed."
  type        = list(string)
}

variable "node_pool_size" {
  type        = number
  description = "The size of the node pool. Valid values are 1, 2, or 4."
  validation {
    condition     = contains([1, 2, 4], var.node_pool_size)
    error_message = "Accepted values for node_pool_size are 1, 2, or 4."
  }
}

variable "node_pool_os_version" {
  default     = "7.9"
  description = "The version of operating system to use for the worker nodes."
  type        = string
}

# Bastion service
variable "bastion_service_access" {
  default     = ["0.0.0.0/0"]
  description = "A list of CIDR blocks to which ssh access to the bastion service must be restricted."
  type        = list(string)
}
