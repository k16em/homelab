locals {
  pve_node      = "pve"
  ipv4_gateway  = "192.168.30.1"
  ipv4_dns      = "192.168.30.1"
  search_domain = "home"

  vms = {}
}

module "vm" {
  for_each = local.vms
  source   = "../modules/arch-vm"

  pve_node        = local.pve_node
  hostname        = each.key
  cpu             = try(each.value.cpu, null)
  mem             = try(each.value.mem, null)
  public_v4_addr  = try(each.value.public_v4_addr, null)
  private_v4_addr = try(each.value.private_v4_addr, null)
  ipv4_gateway    = local.ipv4_gateway
  ipv4_dns        = local.ipv4_dns
  search_domain   = local.search_domain
}
