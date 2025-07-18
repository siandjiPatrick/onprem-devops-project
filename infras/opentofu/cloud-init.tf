data "template_file" "cloudinit"{
  template = file("${path.module}/template/cloud-init/user-data.tmpl")

  vars = {
    hostname = var.cloudInit_hostname
    ssh_pwauth = var.cloudInit_ssh_passAuthentification
    username = var.cloudInit_user_name
    groups = var.cloudInit_user_groups
    lock_passwd = var.cloudInit_lock_password
    user_password = var.cloudInit_user_password
    shell = var.cloudInit_user_shell
    ssh_authorized_keys = join("\n " , [for key in var.cloudInit_ssh_authorized_keys : " - ${key}"])
    packages_to_install = join("\n " , [for pkg in var.cloudInit_packages : "  - ${pkg}"])
    run_command = join("\n " , [for cmd in var.cloudInit_runCommand : "  - ${cmd}"])

  }

}



resource "libvirt_cloudinit_disk" "cloudinit" {
  name      = "${var.cloudInit_hostname}-cloudinit.qcow2"
  pool      = "default"
  user_data = data.template_file.cloudinit.rendered
}