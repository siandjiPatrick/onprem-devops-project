
data "template_file" "cloudinit"{
  for_each = local.all_vm_env_map

  template = file("${path.module}/template/cloud-init/user-data.tmpl")

  vars = {
    hostname = "${var.Vm_name}-${each.key}"
    ssh_pwauth = var.cloudInit_ssh_passAuthentification
    username = var.cloudInit_user_name
    groups = var.cloudInit_user_groups
    lock_passwd = var.cloudInit_lock_password
    user_password = var.cloudInit_user_password
    shell = var.cloudInit_user_shell
    ansible_username = var.cloudInit_ansible_user_name
    ansible_user_password = var.cloudInit_ansible_user_password
    ansible_groups = var.cloudInit_ansible_user_groups
    ssh_authorized_keys = join("\n " , [for key in var.cloudInit_ssh_authorized_keys : " - ${key}"])
    packages_to_install = join("\n " , [for pkg in var.cloudInit_packages : "  - ${pkg}"])
    run_command = join("\n " , [for cmd in var.cloudInit_runCommand : "  - ${cmd}"])

  }

}



resource "libvirt_cloudinit_disk" "cloudinit" {
  for_each = local.all_vm_env_map
  name      = "${each.key}-cloudinit.qcow2"
  pool      = "default"
  user_data = data.template_file.cloudinit[each.key].rendered
}