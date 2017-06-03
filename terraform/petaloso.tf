provider "libvirt" {
  uri = "qemu:///system"
}

module "base" {
  source = "./modules/libvirt/base"
  cc_username = "UC7"
  cc_password = "foo"
  // you need to change prefix and network
  name_prefix = "malloZUP" 
  network_name = "terraform-network" // change to "" if you change bridge below
  bridge = "br7"
}

module "controller" {
  source = "./modules/libvirt/controller"
  base_configuration = "${module.base.configuration}"
  name = "controller"
  branch = "master"
}
