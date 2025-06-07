variable "proxmox_api_url" {
  type        = string
  description = "Proxmox API URL"
}

variable "proxmox_api_token_id" {
  type        = string
  description = "API token ID"
}

variable "proxmox_api_token_secret" {
  type        = string
  description = "API token secret"
  sensitive   = true
}

variable "cloudinit_password" {
  type        = string
  description = "Password for the cloud-init user"
  sensitive   = true
}