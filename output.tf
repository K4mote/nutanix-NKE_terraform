#Data Source use to retrieve the kubeconfig file once the NKE cluster is created
data "nutanix_karbon_cluster_kubeconfig" "kubeconfig_by_name" {
  karbon_cluster_name = nutanix_karbon_cluster.NKE-cluster.name
}

output "nutanix_subnet" {
    value = data.nutanix_subnets.kubernetes_subnet.entities.0.name
    description = "Name of the Subnet inside Nutanix cluster"
    sensitive = false
}

output "NKE_vip" {
    value = nutanix_karbon_cluster.NKE-cluster.active_passive_config[0].external_ipv4_address
    description = "VIP for kube-apiserver"
    sensitive = false
}

output "NKE_name" {
    value = nutanix_karbon_cluster.NKE-cluster.name
    description = "Name of NKE cluster"
    sensitive = false
}

output "Worker_number" {
    value = nutanix_karbon_cluster.NKE-cluster.worker_node_pool[0].num_instances
    description = "Number of Worker nodes"
    sensitive = false
}

output "ETCD_number" {
    value = nutanix_karbon_cluster.NKE-cluster.etcd_node_pool[0].num_instances
    description = "Number of ETCD nodes"
    sensitive = false
}

output "Master_number" {
    value = nutanix_karbon_cluster.NKE-cluster.master_node_pool[0].num_instances
    description = "Number of Master nodes"
    sensitive = false
}

output "NKE_kubeconfig" {
    value = data.nutanix_karbon_cluster_kubeconfig.kubeconfig_by_name
    description = "Kubeconfig of NKE cluster created"
    sensitive = true
}