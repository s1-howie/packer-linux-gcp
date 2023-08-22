variable "s1_mgmt_prefix" {
  type = string
}

variable "s1_api_token" {
  type      = string
  sensitive = true
}

variable "s1_site_token" {
  type      = string
  sensitive = true
}

variable "s1_version_status" {
  type    = string
  default = "ga"
}

variable "image_labels" {
  description = "labels to assign to the VM."
  default     = { team = "cws", environment = "test" }
}

variable "image_description" {
  type    = string
  default = "GCE image with SentinelOne Linux Agent pre-installed"
}

variable "project_id" {
  type    = string
  default = "s1-demo"
}

variable "source_image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "ssh_username" {
  type    = string
  default = "root"
}

variable "zone" {
  type    = string
  default = "us-east1-d"
}
