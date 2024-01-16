Nutanix NKE Terraform
============

> [Nutanix Bible](https://www.nutanixbible.com/18a-book-of-cloud-native-services-nutanix-kubernetes-engine.html)

This example shows how to create Kubernetes clusters with [Nutanix Karbon](https://www.nutanix.com/products/karbon), using infrastructure as code with [Terraform](https://www.terraform.io/)  and the [Nutanix Provider for Terraform](https://registry.terraform.io/providers/nutanix/nutanix/latest). 

## Pre requisites

We will need a working Nutanix cluster enrolled to at least one Prism Central, with NKE [enable](https://portal.nutanix.com/page/documents/details?targetId=Nutanix-Kubernetes-Engine-v2_9:Nutanix-Kubernetes-Engine-v2_9)

- Credentials

You will need to provide credential for the provider, either by adding it in provider.tf, or use SHELL environment variable, as define [here](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs#username).\
You're credentials will be asked during the deployment phase. If you're using the same credentials, you can either use the define variable inside provider.tf, or use environment variable with the `TF_VAR_` prefix as defined [here](https://developer.hashicorp.com/terraform/language/values/variables#environment-variables)

- Network

Prism Central needs to access the Kubernetes Vlan defined in the project on several ports listed [here](https://portal.nutanix.com/page/documents/list?type=software&filterKey=software&filterVal=Ports%20and%20Protocols&productType=Nutanix%20Kubernetes%20Engine)

- .tfvars

In order to define the variables, you MUST use a .tfvars file, here are the variable that should reside inside it :

```bash
karbon_vip = "string" #IP outside managed pool on Karbon Network
karbon_name = "string" #Only letters, numbers and hyphens
karbon_version = "string"
karbon_node_os_version = "string"
storage_container_name = "string"
worker_num_instance = number
etcd_num_instance = number
master_num_instance = number
nutanix_subnet_name = "string"
```

You will be prompted for credentials during the deployment stage.

# Deploying the cluster

```bash
$ terraform init
$ terraform plan -var-file 'YOUR_TFVARS_FILE.tfvars'
$ terraform apply -var-file 'YOUR_TFVARS_FILE.tfvars'
```

## Resources

| Name | Type |
|------|------|
| [nutanix_karbon_cluster.NKE-cluster](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/resources/karbon_cluster) | resource |
| [nutanix_clusters.clusterName](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/data-sources/clusters) | data source |
| [nutanix_karbon_cluster_kubeconfig.kubeconfig_by_name](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/data-sources/karbon_cluster_kubeconfig) | data source |
| [nutanix_subnets.kubernetes_subnet](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/data-sources/subnets) | data source |

_Automatically generated by [terraform-docs](https://github.com/terraform-docs/terraform-docs/)_
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_etcd_num_instance"></a> [etcd\_num\_instance](#input\_etcd\_num\_instance) | Number of ETCD nodes | `number` | n/a | yes |
| <a name="input_karbon_name"></a> [karbon\_name](#input\_karbon\_name) | Name of the NKE cluster | `string` | n/a | yes |
| <a name="input_karbon_node_os_version"></a> [karbon\_node\_os\_version](#input\_karbon\_node\_os\_version) | Version of the NKE OS deployed | `string` | n/a | yes |
| <a name="input_karbon_version"></a> [karbon\_version](#input\_karbon\_version) | Version of Kubernetes for the specified cluster | `string` | n/a | yes |
| <a name="input_karbon_vip"></a> [karbon\_vip](#input\_karbon\_vip) | Floatted IP for masters | `string` | n/a | yes |
| <a name="input_master_num_instance"></a> [master\_num\_instance](#input\_master\_num\_instance) | Number of Master nodes | `number` | n/a | yes |
| <a name="input_nutanix_pc_password"></a> [nutanix\_pc\_password](#input\_nutanix\_pc\_password) | Password for Prism Central | `string` | n/a | yes |
| <a name="input_nutanix_pc_username"></a> [nutanix\_pc\_username](#input\_nutanix\_pc\_username) | Username for Prism Central | `string` | n/a | yes |
| <a name="input_nutanix_subnet_name"></a> [nutanix\_subnet\_name](#input\_nutanix\_subnet\_name) | Subnet Name on Prism | `string` | n/a | yes |
| <a name="input_storage_container_name"></a> [storage\_container\_name](#input\_storage\_container\_name) | Storage Container use for NKE | `string` | n/a | yes |
| <a name="input_worker_num_instance"></a> [worker\_num\_instance](#input\_worker\_num\_instance) | Number of Worker nodes | `number` | n/a | yes |

_Automatically generated by [terraform-docs](https://github.com/terraform-docs/terraform-docs/)_
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ETCD_number"></a> [ETCD\_number](#output\_ETCD\_number) | Number of ETCD nodes |
| <a name="output_Master_number"></a> [Master\_number](#output\_Master\_number) | Number of Master nodes |
| <a name="output_NKE_kubeconfig"></a> [NKE\_kubeconfig](#output\_NKE\_kubeconfig) | Kubeconfig of NKE cluster created |
| <a name="output_NKE_name"></a> [NKE\_name](#output\_NKE\_name) | Name of NKE cluster |
| <a name="output_NKE_vip"></a> [NKE\_vip](#output\_NKE\_vip) | VIP for kube-apiserver |
| <a name="output_Worker_number"></a> [Worker\_number](#output\_Worker\_number) | Number of Worker nodes |
| <a name="output_nutanix_subnet"></a> [nutanix\_subnet](#output\_nutanix\_subnet) | Name of the Subnet inside Nutanix cluster |

_Automatically generated by [terraform-docs](https://github.com/terraform-docs/terraform-docs/)_
# Other

## Log in to your newly created NKE cluster

> [Official Documentation](https://github.com/nutanix/kubectl-karbon)

- Pre-reqs:
  - https://krew.sigs.k8s.io/docs/user-guide/setup/install/
  - https://github.com/nutanix/kubectl-karbon#kubectl-plugins

## Deploy Azure ARC
- [Nutanix Blog Post 1](https://www.nutanix.dev/2022/05/11/nutanix-nke-microsoft-azure-arc-part-1/)
- [Nutanix Blog Post 2](https://www.nutanix.dev/2022/05/16/nutanix-nke-microsoft-azure-arc-part-2/)

## Known issues

- Aliases

Nutanix provider do not support usage of "alias" directive in provider definition.
When set, the provider will not load "Karbon" module used to create a NKE cluster.
