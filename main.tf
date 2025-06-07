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
  name        = "proxy-lb"
  target_node = "PVE-Max"
  clone       = "proxy-lb"
  os_type     = "cloud-init"

  cores  = 2
  memory = 2048

  disk {
    type    = "scsi"
    storage = "local"
    size    = "10G"
  }

  network {
    model  = "virtio"
    bridge = "vmbr1"
  }

  cloudinit {
    user      = "BDD-usr"
    password  = var.cloudinit_password
    ipconfig0 = "ip=192.168.10.12/24,gw=192.168.10.1"
    dns       = ["8.8.8.8"]
  }

  boot     = "cdn"
  bootdisk = "scsi0"
}