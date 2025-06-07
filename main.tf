resource "proxmox_vm_qemu" "proxy_lb" {
  name        = "Proxy-test"
  target_node = "PVE-Max"
  clone       = "PROXY-LB"
  full_clone  = true
  vmid        = 120

  cores   = 2
  sockets = 1
  memory  = 2048
  cpu     = "host"

  os_type   = "cloud-init"
  agent     = 1
  onboot    = true
  scsihw    = "virtio-scsi-pci"
  boot      = "order=scsi0"
  bootdisk  = "scsi0"

  ciuser     = "proxy-usr"
  cipassword = var.cloudinit_password
  ipconfig0  = "ip=192.168.10.100/24,gw=192.168.10.1"
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