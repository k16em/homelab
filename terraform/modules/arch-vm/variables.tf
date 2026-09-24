variable "pve_node" {
  type = string
}

variable "hostname" {
  type = string
}

variable "cpu" {
  type     = number
  default  = 2
  nullable = false
}

variable "mem" {
  type     = number
  default  = 4096
  nullable = false
}

variable "public_v4_addr" {
  type    = string
  default = null
}

variable "private_v4_addr" {
  type    = string
  default = null
}

variable "ipv4_gateway" {
  type    = string
  default = null
}

variable "ipv4_dns" {
  type    = string
  default = null
}

variable "search_domain" {
  type    = string
  default = "home"
}

variable "template_vmid" {
  type    = number
  default = 1000
}

variable "vmid" {
  type    = number
  default = null
}

variable "vm_storage" {
  type    = string
  default = "storage01"
}

variable "disk_size" {
  type    = string
  default = "32G"
}

variable "cloud_init_storage" {
  type    = string
  default = "local"
}

variable "pacman_mirror_server" {
  type = string
}

variable "pacman_mirror_port" {
  type     = number
  default  = 7878
  nullable = false
}
