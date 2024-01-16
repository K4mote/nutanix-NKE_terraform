provider "nutanix" {
  # use env variable NUTANIX_USERNAME 
  # use env variable NUTANIX_PASSWORD
  endpoint = "FQDN of Prism Central"
  port     = "9440"
  insecure = false
  wait_timeout = 10
}
