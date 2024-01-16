terraform {
  required_providers {
    # https://github.com/nutanix/terraform-provider-nutanix
    nutanix = {
      source  = "nutanix/nutanix"
      version = ">=1.9.2, <2.0" #Allow minor version update
    }
  }
}

#Data Source used to retrieve cluster UUID
data "nutanix_clusters" "clusterName" {}

#Data Source used to retrieve UUID of subnet where NKE should be
data "nutanix_subnets" "kubernetes_subnet" {
  metadata {
    filter = "name==${var.nutanix_subnet_name}"
  }
}

resource "nutanix_karbon_cluster" "NKE-cluster" {
  name       = var.karbon_name 
  version    = var.karbon_version
  
  storage_class_config {
    reclaim_policy = "Delete"
    volumes_config {
      file_system                = "ext4"
      flash_mode                 = true
      username                   = var.nutanix_pc_username
      password                   = var.nutanix_pc_password
      prism_element_cluster_uuid = data.nutanix_clusters.clusterName.entities.0.metadata.uuid
      storage_container          = var.storage_container_name
    }
  }

  active_passive_config {
    external_ipv4_address = var.karbon_vip
  }

  cni_config {
    node_cidr_mask_size = 24
    pod_ipv4_cidr       = "172.17.0.0/16"
    service_ipv4_cidr   = "172.18.0.0/16"
  }

  worker_node_pool {
    node_os_version = var.karbon_node_os_version
    num_instances   = var.worker_num_instance
    ahv_config {
      network_uuid               = data.nutanix_subnets.kubernetes_subnet.entities.0.metadata.uuid
      prism_element_cluster_uuid = data.nutanix_clusters.clusterName.entities.0.metadata.uuid
      cpu                        = 8
      memory_mib                 = 16384
    }
  }

  etcd_node_pool {
    node_os_version = var.karbon_node_os_version
    num_instances   = var.etcd_num_instance
    ahv_config {
      network_uuid               = data.nutanix_subnets.kubernetes_subnet.entities.0.metadata.uuid
      prism_element_cluster_uuid = data.nutanix_clusters.clusterName.entities.0.metadata.uuid
      cpu                        = 4
      memory_mib                 = 8192
    }
  }

  master_node_pool {
    node_os_version = var.karbon_node_os_version
    num_instances   = var.master_num_instance
    ahv_config {
      network_uuid               = data.nutanix_subnets.kubernetes_subnet.entities.0.metadata.uuid
      prism_element_cluster_uuid = data.nutanix_clusters.clusterName.entities.0.metadata.uuid
      cpu                        = 4
      memory_mib                 = 4096
    }
  }
  timeouts {
    create = "30m"
    update = "30m"
    delete = "10m"
    }
}

