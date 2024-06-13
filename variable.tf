variable "local_network_gateway_list" {
  type = list(any)
  description = "list of local network gateways config"
}

variable "resource_group_output" {
  type = map(any)
  description = "object list of resource group"
}