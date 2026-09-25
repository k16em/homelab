resource "proxmox_vm_qemu" "vm" {
  name        = coalesce(var.name, var.hostname)
  target_node = var.pve_node
  vmid        = var.vmid
  clone_id    = var.template_vmid
  tags        = var.tags
  full_clone  = true

  agent              = 1
  os_type            = "cloud-init"
  qemu_os            = "l26"
  scsihw             = "virtio-scsi-single"
  boot               = "order=scsi0"
  memory             = var.mem
  start_at_node_boot = true
  power_state        = "running"
  skip_ipv6          = true

  cpu {
    type    = "x86-64-v3"
    cores   = var.cpu
    sockets = 1
  }

  startup_shutdown {
    order            = -1
    shutdown_timeout = -1
    startup_delay    = -1
  }

  serial {
    id   = 0
    type = "socket"
  }

  vga {
    type = "serial0"
  }

  dynamic "network" {
    for_each = var.public_v4_addr != null ? [0] : []
    content {
      id      = 0
      model   = "virtio"
      bridge  = "vmbr0"
      macaddr = local.public_mac
    }
  }

  dynamic "network" {
    for_each = var.private_v4_addr != null ? [var.public_v4_addr != null ? 1 : 0] : []
    content {
      id      = network.value
      model   = "virtio"
      bridge  = "vmbr1"
      macaddr = local.private_mac
    }
  }

  disks {
    scsi {
      scsi0 {
        disk {
          storage    = var.vm_storage
          size       = var.disk_size
          cache      = "writeback"
          discard    = true
          emulatessd = true
        }
      }
    }
    ide {
      ide2 {
        cdrom {
          iso = proxmox_cloud_init_disk.ci.id
        }
      }
    }
  }
}
