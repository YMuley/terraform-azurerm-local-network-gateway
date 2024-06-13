locals {
  gateway = { for gateway in var.local_network_gateway_list : gateway.name => gateway}
}