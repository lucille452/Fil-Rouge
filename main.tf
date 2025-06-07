resource "proxmox_vm_qemu" "proxy_lb" {
  name        = "Proxy-test"
  clone       = "PROXY-LB"
  target_node = "PVE-Max"
  vmid = 120

  cores   = 2
  sockets = 1
  memory  = 2048
  cpu     = "host"

  os_type     = "cloud-init"
  qemu_os = "l26"
  agent    = 1
  scsihw   = "virtio-scsi-pci"
  onboot = true
  ciuser       = "proxy-usr"
  cipassword   = var.cloudinit_password
  ipconfig0    = "ip=192.168.10.100/24,gw=192.168.10.1"
  nameserver   = "8.8.8.8"

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage    = "local"
          size       = "10G"
        }
      }
    }
  }
  network {
    model  = "virtio"
    bridge = "vmbr1"
  }
}