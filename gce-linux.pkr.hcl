# Reference: https://developer.hashicorp.com/packer/plugins/builders/googlecompute

packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "~> 1"
    }
  }
}

# Timestamp to help differentiate image names by their build timestamps.
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "googlecompute" "gce_image" {
  image_description   = var.image_description
  image_labels        = var.image_labels
  image_name          = "packer-${var.source_image_family}-s1-${local.timestamp}"
  project_id          = var.project_id
  source_image_family = var.source_image_family
  ssh_username        = var.ssh_username
  zone                = var.zone
}


build {
  sources = ["source.googlecompute.gce_image"]
  
  # If using the ubuntu-2204-lts or ubuntu-minimal-2204-lts images, uncomment the 3 lines below to allow apt to refresh its cache before downloading the jq utility.
  # provisioner "shell" {
  #   inline = ["sudo apt-get update"]
  # }

  provisioner "shell" {
    inline = [
      "curl -L https://raw.githubusercontent.com/s1-howie/s1-agents-helper/master/s1-agent-helper-packer.sh -o /tmp/s1-agent-helper-packer.sh",
      "chmod u+x /tmp/s1-agent-helper-packer.sh",
      "sudo /tmp/s1-agent-helper-packer.sh ${var.s1_mgmt_prefix} ${var.s1_api_token} ${var.s1_site_token} ${var.s1_version_status}"
    ]
  }
}

