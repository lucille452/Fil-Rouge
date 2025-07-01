resource "proxmox_vm_qemu" "proxy_lb" {
  for_each = local.vm
  name        = each.key
  target_node = "PVE-Max"
  clone       = "PROXY-LB"
  full_clone  = true
  vmid        = each.value.vmid

  cores   = 4
  sockets = 1
  memory  = 2048
  cpu     = "host"

  os_type   = "cloud-init"
  agent     = 1
  onboot    = true
  scsihw    = "virtio-scsi-pci"
  boot      = "order=scsi0"
  bootdisk  = "scsi0"

  ciuser     = each.value.username
  cipassword = var.cloudinit_password
  ipconfig0  = each.value.ip
  sshkeys = "./ssh.txt"
  nameserver = "8.8.8.8"

  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local"
          size    = "40G"
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = "local"
        }
      }
    }
  }

  network {
    model  = "virtio"
    bridge = "vmbr1"
  }
}