locals {
  vm = {
    web1-srv = { username = "web1-usr", ip = "ip=192.168.10.11/24,gw=192.168.10.1", vmid = 102}
    web2-srv = { username = "web2-usr", ip = "ip=192.168.10.13/24,gw=192.168.10.1", vmid = 103}
    proxy-srv = { username = "proxy-usr", ip = "ip=192.168.10.12/24,gw=192.168.10.1", vmid = 120}
    bdd-srv = { username = "bdd-usr", ip = "ip=192.168.10.14/24,gw=192.168.10.1", vmid = 121}
    monit-srv = { username = "monit-usr", ip = "ip=192.168.10.15/24,gw=192.168.10.1", vmid = 122}
  }
}