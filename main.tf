terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

variable "proxmox_api_url" {
}

variable "proxmox_api_token_id" {
  description = "API Token ID"
  type        = string
  sensitive   = true
}

variable "proxmox_api_token_secret" {
  description = "API Token Secret"
  type        = string
  sensitive   = true
}

provider "proxmox" {
  pm_tls_insecure = true
  pm_api_url = var.proxmox_api_url
  pm_api_token_id = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
}

resource "proxmox_vm_qemu" "resource-name" {
  name        = "VM-name"
  target_node = "PVE-Max"

  disks {
    ide {
      ide2 {
        cdrom {
          iso = "ISO file"
        }
      }
    }
  }

  ### or for a Clone VM operation
  # clone = "template to clone"

  ### or for a PXE boot VM operation
  # pxe = true
  # boot = "scsi0;net0"
  # agent = 0
}