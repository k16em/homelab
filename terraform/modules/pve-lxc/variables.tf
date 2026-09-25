variable "pve_node" {
  type = string
}

variable "vmid" {
  type = number
}

variable "hostname" {
  type = string
}

variable "cores" {
  type = number
}

variable "memory" {
  type = number
}

variable "disk_size" {
  type = string
}

variable "storage" {
  type    = string
  default = "storage01"
}

variable "bridge" {
  type = string
}

variable "ipv4_address" {
  type = string
}

variable "ipv4_gateway" {
  type = string
}

variable "hwaddr" {
  type    = string
  default = null
}

variable "nameserver" {
  type = string
}

variable "tags" {
  type = string
}
