locals {
  ssh_public_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH1+DvxUVbKQVrRsRhZEX/aqdox/MU3nC9bqmJBDz+by",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMz2Z8uOw2WCkEQgaQtpDxCNqAPsRFiVCiXQrSzzo+vb",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKZJc89W8z5FzkZpbA4Hl6RXyX5t8nlWingBKMlFPAaw",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHFKnlIyCgW31Fah9Lu/f0Sn2SYvSN69VkoBqJBSOSV0",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKJfrFtXf4ZZ0Cvc8imYopa8lEB8pL0pozsp72uebybk",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDalCgHF6xdItVJ+372THFRFvnHwiLfDnhKHqngQwb/z",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIWhmPjY0gQuN/SuSiZd+un5gLgIeepMTRz6Oe7pEmTL",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH6lbSY1sE2SNc3aHonvKqIW+DC3VeT6D4OfFo6Ar16q",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJGuiuJAh/R4P13e05iv8rKMJx5Pn/KpqoMxG7eD4sQ5",
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIIwQTRjppU1lg4MVEmLLkOe3f8nB8/iw3wsSitimnW1NAAAABHNzaDo=",
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIPI+wvT7hPz9q1+UqueKhlxv45aFaHCNJCFB3co0e3qhAAAABHNzaDo=",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILvAgOHU6Ct4QYDIXZgXJARFvqDCRROdnKAzdNE74jHY",
  ]

  public_mac  = join(":", concat(["02"], regexall("..", substr(sha1("${var.hostname}-public"), 0, 10))))
  private_mac = join(":", concat(["02"], regexall("..", substr(sha1("${var.hostname}-private"), 0, 10))))
}

resource "proxmox_cloud_init_disk" "ci" {
  name     = var.hostname
  pve_node = var.pve_node
  storage  = var.cloud_init_storage

  meta_data = yamlencode({
    "instance-id"  = sha1(var.hostname)
    local-hostname = var.hostname
  })

  user_data = "#cloud-config\n${yamlencode({
    hostname        = var.hostname
    fqdn            = "${var.hostname}.${var.search_domain}"
    timezone        = "Asia/Tokyo"
    ssh_pwauth      = false
    disable_root    = true
    package_update  = true
    package_upgrade = true
    packages        = ["archlinux-keyring", "pacman-contrib", "sudo", "openssh", "zsh", "zsh-completions", "python"]
    groups          = ["sudo"]
    users = [
      {
        name                = "maintainer"
        groups              = ["wheel", "sudo"]
        shell               = "/bin/bash"
        sudo                = "ALL=(ALL:ALL) NOPASSWD: ALL"
        lock_passwd         = true
        ssh_authorized_keys = local.ssh_public_keys
      },
    ]
    write_files = [
      {
        path        = "/etc/ssh/sshd_config.d/10-hardening.conf"
        permissions = "0644"
        content     = "PermitRootLogin no\nPasswordAuthentication no\n"
      },
      {
        path        = "/etc/pacman.d/mirrorlist"
        permissions = "0644"
        content     = "Server = http://${var.pacman_mirror_server}:${var.pacman_mirror_port}/$repo/os/$arch\n"
      },
    ]
    runcmd = [
      ["sed", "-i", "s/^#DisableSandbox$/DisableSandbox/", "/etc/pacman.conf"],
      "pacman -Syu --needed --noconfirm zsh zsh-completions && usermod --shell /usr/bin/zsh maintainer",
      ["systemctl", "enable", "--now", "sshd"],
    ]
    power_state = {
      mode      = "reboot"
      condition = true
    }
  })}"

  network_config = yamlencode({
    version = 2
    ethernets = merge(
      {
        for addr in compact([var.public_v4_addr]) : "public" => {
          match     = { macaddress = local.public_mac }
          dhcp4     = false
          addresses = [addr]
          routes    = [for gw in compact([var.ipv4_gateway]) : { to = "default", via = gw }]
          nameservers = {
            addresses = compact([var.ipv4_dns])
            search    = [var.search_domain]
          }
        }
      },
      {
        for addr in compact([var.private_v4_addr]) : "private" => {
          match     = { macaddress = local.private_mac }
          dhcp4     = false
          addresses = [addr]
        }
      },
    )
  })
}
