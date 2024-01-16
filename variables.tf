variable "nutanix_pc_username" {
  description = "Username for Prism Central"
  type = string
  sensitive = false
}

variable "nutanix_pc_password" {
  description = "Password for Prism Central"
  type = string
  sensitive = true
}

variable "karbon_vip" {
  description = "Floatted IP for masters"
  type = string
}

variable "storage_container_name" {
  description = "Storage Container use for NKE"
  type = string
}

variable "karbon_name" {
  description = "Name of the NKE cluster"
  type = string
}

variable "karbon_version" {
  description = "Version of Kubernetes for the specified cluster"
  type = string
}

variable "karbon_node_os_version" {
  description = "Version of the NKE OS deployed"
  type = string
}

variable "worker_num_instance" {
  description = "Number of Worker nodes"
  type = number
}

variable "etcd_num_instance" {
  description = "Number of ETCD nodes"
  type = number
}

variable "master_num_instance" {
  description = "Number of Master nodes"
  type = number
}
variable "nutanix_subnet_name" {
  description = "Subnet Name on Prism"
  type = string
}