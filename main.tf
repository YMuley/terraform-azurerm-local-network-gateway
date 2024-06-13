resource "azurerm_local_network_gateway" "local_gateway" {
    for_each                = local.gateway
    name                    = each.value.name
    resource_group_name     = var.resource_group_output[each.value.resource_group_name].name
    location                = var.resource_group_output[each.value.resource_group_name].location
    gateway_address         = each.value.gateway_address
    address_space           = each.value.address_space

    dynamic "bgp_settings" {
      for_each = each.value.bgp_settings == [] ? [] : each.value.bgp_settings
      content {
        asn                     = bgp_settings.value.asn
        bgp_peering_address     = bgp_settings.value.bgp_peering_address
        peer_weight             = bgp_settings.value.peer_weight
      }
    }
}