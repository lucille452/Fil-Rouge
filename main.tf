terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = ">= 2.9.14"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
  pm_tls_insecure     = true
}

resource "proxmox_vm_qemu" "proxy_lb" {
  name        = "Proxy"
  target_node = "PVE-Max"
  clone       = "PROXY-LB"
  full_clone  = true
  os_type     = "cloud-init"

  cores   = 2
  sockets = 1
  memory  = 2048
  cpu     = "host"

  scsihw   = "virtio-scsi-pci"
  boot     = "cdn"
  bootdisk = "scsi0"
  agent    = 1

  disk {
    type     = "scsi"
    storage  = "local"
    size     = "10G"
    format   = "qcow2"
    iothread = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr1"
  }

  ipconfig0    = "ip=192.168.10.100/24,gw=192.168.10.1"
  nameserver   = "8.8.8.8"
  ciuser       = "ubuntu"
  cipassword   = var.cloudinit_password
}