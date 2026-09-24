locals {
  pve_node      = "pve"
  ipv4_gateway  = "192.168.30.1"
  ipv4_dns      = "192.168.30.1"
  search_domain = "home"

  pacman_mirror_server = "192.168.30.61"

  vms = {
    k8s-cp01 = { vmid = 301, cpu = 2, mem = 4096, public_v4_addr = "192.168.30.41/24", private_v4_addr = "192.168.20.41/24" }
    k8s-wk01 = { vmid = 351, cpu = 2, mem = 4096, public_v4_addr = "192.168.30.81/24", private_v4_addr = "192.168.20.81/24" }
    k8s-wk02 = { vmid = 352, cpu = 2, mem = 4096, public_v4_addr = "192.168.30.82/24", private_v4_addr = "192.168.20.82/24" }
    k8s-wk03 = { vmid = 353, cpu = 2, mem = 4096, public_v4_addr = "192.168.30.83/24", private_v4_addr = "192.168.20.83/24" }
  }
}

module "vm" {
  for_each = local.vms
  source   = "../modules/arch-vm"

  pve_node        = local.pve_node
  hostname        = each.key
  vmid            = try(each.value.vmid, null)
  cpu             = try(each.value.cpu, null)
  mem             = try(each.value.mem, null)
  public_v4_addr  = try(each.value.public_v4_addr, null)
  private_v4_addr = try(each.value.private_v4_addr, null)
  ipv4_gateway    = local.ipv4_gateway
  ipv4_dns        = local.ipv4_dns
  search_domain   = local.search_domain

  pacman_mirror_server = local.pacman_mirror_server
}
