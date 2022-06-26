<!-- markdownlint-configure-file {
  "MD013": {
    "code_blocks": false,
    "tables": false
  },
  "MD033": false,
  "MD041": false
} -->



<div align="center">


  
# Terraform
  
</div>


## Getting started

 _Terraform module must declare which providers it requires_
 
```sh
 cat terraform-docker.tf
 
 # providers
 terraform {
  required_providers {
    digitalocean = {
```
 **DigitalOcean**[SetUpProvider which work](https://www.digitalocean.com/community/tutorials/how-to-use-terraform-with-digitalocean)
 
 **Token SetUp**[SetupToken](https://learn.hashicorp.com/tutorials/terraform/digitalocean-provider?in=terraform/applications)
 
 run 
 
```sh
 terraform init
```

_Terraform resources_
 
A resource block defines a component of your infrastructure. 

A resource might be a physical or virtual component such as a Droplet, or managed services such as the DigitalOcean App platform.
 
```sh
 resource "digitalocean_ssh_key" "melany"
 ...
 resource "digitalocean_droplet" "site" 
 ....
 resource "digitalocean_domain" "melany"
 ....
```
 
- the resource type is digitalocean_droplet and the name is site.
 
- the resource type and resource name form a unique ID for the resource. For example, the ID for your Droplet instance is **digitalocean_droplet.site**


_Terraform configuration uses_

The user_data attribute and the file function to pass a cloud-init script to your Droplet.

Your Droplet will automatically run this cloud-init script and provision itself with your userdata.yaml.

```sh
resource "digitalocean_droplet" "site" {
  ...
  ...
  user_data= "${file("userdata.yaml")}"
```


_Terraform outputs_


Use to connect your Terraform projects with other parts of your infrastructure.


_**Deploy It**_

```sh
terraform plan

terraform apply
```








 
 
 
 
 
 
 
 
 
