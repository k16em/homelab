resource "proxmox_lxc" "ct" {
  target_node  = var.pve_node
  vmid         = var.vmid
  hostname     = var.hostname
  arch         = "amd64"
  ostype       = "archlinux"
  unprivileged = true
  onboot       = true
  cores        = var.cores
  memory       = var.memory
  swap         = 0
  nameserver   = var.nameserver
  tags         = var.tags

  bwlimit              = 0
  force                = false
  ignore_unpack_errors = false
  restore              = false
  template             = false
  unique               = false

  features {
    nesting = true
    fuse    = true
  }

  rootfs {
    storage = var.storage
    size    = var.disk_size

    acl       = false
    quota     = false
    replicate = false
    ro        = false
    shared    = false
  }

  network {
    name   = "eth0"
    bridge = var.bridge
    ip     = var.ipv4_address
    gw     = var.ipv4_gateway
    hwaddr = var.hwaddr
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      target_node,
      start,
      cmode,
      cpulimit,
      rootfs[0].storage,
    ]
  }
}
