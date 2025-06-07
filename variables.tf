variable "proxmox_api_url" {
  description = "URL de l'API Proxmox"
}

variable "proxmox_api_token_id" {
  description = "Token ID Proxmox (ex: root@pam!terraform)"
}

variable "proxmox_api_token_secret" {
  description = "Clé secrète liée au token"
  sensitive   = true
}

variable "cloudinit_password" {
  description = "Mot de passe du user ubuntu injecté via Cloud-Init"
  sensitive   = true
}