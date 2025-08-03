



resource "libvirt_cloudinit_disk" "cloudinit" {
  for_each = local.vm_envs_map
  name     = "${each.key}-cloudinit.iso"
  pool     = "default"

  user_data = templatefile("${path.module}/template/cloud-init/user-data.tmpl", {
    hostname   = "${each.key}"
    ssh_pwauth = true

    users = [
      {
        name                = var.vm_config[split("-", each.key)[0]].user_data_properties.user_name
        groups              = var.vm_config[split("-", each.key)[0]].user_data_properties.user_groups
        shell               = var.vm_config[split("-", each.key)[0]].user_data_properties.user_shell
        sudo                = "ALL=(ALL) NOPASSWD:ALL"
        lock_passwd         = var.vm_config[split("-", each.key)[0]].user_data_properties.lock_password
        passwd              = var.vm_config[split("-", each.key)[0]].user_data_properties.user_password
        ssh_authorized_keys = [file(var.vm_config[split("-", each.key)[0]].user_data_properties.ssh_authorized_keys_path)]
      }
    ]

    packages_to_install = var.vm_config[split("-", each.key)[0]].user_data_properties.packages
    run_command         = var.vm_config[split("-", each.key)[0]].user_data_properties.runCommand
  })


}
