resource "proxmox_vm_qemu" "vm" {
  name        = var.hostname
  target_node = var.pve_node
  vmid        = var.vmid
  clone_id    = var.template_vmid
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

  serial {
    id   = 0
    type = "socket"
  }

  vga {
    type = "serial0"
  }

  network {
    id      = 0
    model   = "virtio"
    bridge  = "vmbr0"
    macaddr = local.public_mac
  }

  network {
    id      = 1
    model   = "virtio"
    bridge  = "vmbr1"
    macaddr = local.private_mac
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
