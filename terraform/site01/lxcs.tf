locals {
  lxc_networks = {
    public = {
      bridge  = "vmbr0"
      gateway = "192.168.30.1"
    }
    private = {
      bridge  = "vmbr1"
      gateway = "192.168.20.1"
    }
  }

  lxcs = {
    tkpve-bastion01    = { vmid = 100, cores = 2, memory = 1024, disk_size = "16G", network = "public", ipv4_address = "192.168.30.30/24", hwaddr = "BC:24:11:E4:8D:2F", tags = "tailscale;tk" }
    tkpve-pihole01     = { vmid = 101, cores = 2, memory = 1024, disk_size = "16G", network = "public", ipv4_address = "192.168.30.3/24", hwaddr = "BC:24:11:38:DE:E9", tags = "k8s;tk" }
    tkpve-bastion01p   = { vmid = 102, cores = 1, memory = 2048, disk_size = "16G", network = "private", ipv4_address = "192.168.20.60/24", hwaddr = "BC:24:11:CE:A9:40", tags = "pv;tailscale;tk" }
    tkpve-cache01      = { vmid = 200, cores = 2, memory = 4096, disk_size = "128G", network = "public", ipv4_address = "192.168.30.61/24", hwaddr = "BC:24:11:26:C8:09", tags = "k8s;tk" }
    tkpve-memory01     = { vmid = 603, cores = 2, memory = 2048, disk_size = "16G", network = "private", ipv4_address = "192.168.20.71/24", hwaddr = "BC:24:11:21:64:3D", tags = "llm;pv;tk" }
    tkpve-worker       = { vmid = 700, cores = 4, memory = 4096, disk_size = "32G", network = "private", ipv4_address = "192.168.20.18/24", hwaddr = "BC:24:11:AB:A1:5C", tags = "pv;tk" }
    tkpve-hermes01     = { vmid = 701, cores = 4, memory = 4096, disk_size = "32G", network = "private", ipv4_address = "192.168.20.36/24", hwaddr = "BC:24:11:D0:C6:D8", tags = "llm;pv;tk" }
    tkpve-db01p        = { vmid = 312, cores = 2, memory = 2048, disk_size = "32G", network = "private", ipv4_address = "192.168.20.52/24", tags = "k8s;pv;tk" }
  }
}

module "lxc" {
  for_each = local.lxcs
  source   = "../modules/pve-lxc"

  pve_node     = local.pve_node
  vmid         = each.value.vmid
  hostname     = each.key
  cores        = each.value.cores
  memory       = each.value.memory
  disk_size    = each.value.disk_size
  bridge       = local.lxc_networks[each.value.network].bridge
  ipv4_address = each.value.ipv4_address
  ipv4_gateway = local.lxc_networks[each.value.network].gateway
  hwaddr       = try(each.value.hwaddr, null)
  nameserver   = local.lxc_networks[each.value.network].gateway
  tags         = each.value.tags
}
