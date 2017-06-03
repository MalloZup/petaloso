module "controller" {
  source = "../host"
  base_configuration = "${var.base_configuration}"
  name = "${var.name}"
  image = "sles12sp1"
  memory = "${var.memory}"
  running = "${var.running}"
  mac = "${var.mac}"
  additional_repos = "${var.additional_repos}"
  additional_packages = "${var.additional_packages}"
  grains = <<EOF

mirror: ${var.base_configuration["mirror"]}
role: controller
branch : ${var.branch}
EOF
}
