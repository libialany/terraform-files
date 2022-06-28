# providers
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

#set variables
variable "do_token" {}
variable "pvt_key" {}

#save key
data "digitalocean_ssh_key" "melany" {
  name = "melany"
}

# create a droplet
resource "digitalocean_droplet" "site" {
  count= 1
  image= "ubuntu-18-04-x64"
  name=  "service-witte-${count.index}"
  region= "nyc1"
  size=   "s-1vcpu-1gb"
  ssh_keys = [ data.digitalocean_ssh_key.melany.id]

  provisioner "remote-exec" {
  inline = ["sudo apt update", "sudo apt install python3 -y", "echo Docker Compose installing ...."]

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.pvt_key)
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u root -i '${self.ipv4_address},' --private-key ${var.pvt_key} playbook-docker-compose.yml"
  }
}

# save ipv4_address
output "droplet_ip_addresses" {
  value = {
    for droplet in digitalocean_droplet.site:
        droplet.name => droplet.ipv4_address
  }
}
