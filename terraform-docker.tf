# providers
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# create ssh key 
resource "digitalocean_ssh_key" "melany" {
  name = "melany"
  public_key= "${file("id_rsa.pub")}"
}

# create a droplet
resource "digitalocean_droplet" "site" {
  image= "ubuntu-18-04-x64"
  name=  "service-witte"
  region= "nyc1"
  size=   "s-1vcpu-1gb"
  user_data= "${file("userdata.yaml")}"
  ssh_keys= ["${digitalocean_ssh_key.melany.fingerprint}"]
}

#create a droplet dns
resource "digitalocean_domain" "melany" {
    name="melany.com"
}

resource "digitalocean_record" "www" {
    domain = "${digitalocean_domain.melany.name}"
    type = "A"
    name = "melany"
    ttl = "50"
    value = "${digitalocean_droplet.site.ipv4_address}"
}
