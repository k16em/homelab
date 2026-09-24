import {
  for_each = local.lxcs
  to       = module.lxc[each.key].proxmox_lxc.ct
  id       = "${local.pve_node}/lxc/${each.value.vmid}"
}
