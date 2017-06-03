terraform {
    required_version = ">= 0.8.0"
}

resource "libvirt_volume" "sles12sp1" {
  name = "${var.name_prefix}sles12sp1"
  source = "http://download.suse.de/ibs/Devel:/Galaxy:/Terraform:/Images/images/sles12sp1.x86_64.qcow2"
  pool = "${var.pool}"
}

resource "libvirt_volume" "sles12sp2" {
  name = "${var.name_prefix}sles12sp2"
  source = "http://download.suse.de/ibs/Devel:/Galaxy:/Terraform:/Images/images/sles12sp2.x86_64.qcow2"
  pool = "${var.pool}"
}

output "configuration" {
  value = {
    network_name = "${var.network_name}"
    cc_username = "${var.cc_username}"
    cc_password = "${var.cc_password}"
    timezone = "${var.timezone}"
    mirror = "${var.mirror == "" ? "null" : var.mirror}"
    ssh_key_path = "${var.ssh_key_path}"
    pool = "${var.pool}"
    bridge = "${var.bridge}"
    use_avahi = "${var.use_avahi}"
    domain = "${var.domain}"
    name_prefix = "${var.name_prefix}"
  }
}
