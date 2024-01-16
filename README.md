Nutanix NKE Terraform
============

> [Nutanix Bible](https://www.nutanixbible.com/18a-book-of-cloud-native-services-nutanix-kubernetes-engine.html)

This example shows how to create Kubernetes clusters with [Nutanix Karbon](https://www.nutanix.com/products/karbon), using infrastructure as code with [Terraform](https://www.terraform.io/)  and the [Nutanix Provider for Terraform](https://registry.terraform.io/providers/nutanix/nutanix/latest). 

# Pre requisites

We will need a working Nutanix cluster enrolled to at least one Prism Central, with NKE [enable](https://portal.nutanix.com/page/documents/details?targetId=Nutanix-Kubernetes-Engine-v2_9:Nutanix-Kubernetes-Engine-v2_9)

- Credentials

You will need to provide credential for the provider, either by adding it in provider.tf, or use SHELL environment variable.\
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

# Outputs

TBD

# Deploying the cluster

```bash
$ terraform init
$ terraform plan -var-file 'YOUR_TFVARS_FILE.tfvars'
$ terraform apply -var-file 'YOUR_TFVARS_FILE.tfvars'
```

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
