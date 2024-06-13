resource "azurerm_local_network_gateway" "local_gateway" {
    for_each                = local.gateway
    name                    = each.value.name
    resource_group_name     = var.resource_group_output[each.value.resource_group_name].name
    location                = var.resource_group_output[each.value.resource_group_name].location
    gateway_address         = each.value.gateway_fqdn != null ? null : each.value.gateway_address
    gateway_fqdn            = each.value.gateway_address != null ? null : each.value.gateway_fqdn
    address_space           = each.value.enable_bgp != true ? each.value.address_space : null
    tags                    = each.value.tags

    dynamic "bgp_settings" {
      for_each = each.value.enable_bgp == true ? each.value.bgp_settings : []
      content {
        asn                     = bgp_settings.value.asn
        bgp_peering_address     = bgp_settings.value.bgp_peering_address
        peer_weight             = bgp_settings.value.peer_weight
      }
    }
}