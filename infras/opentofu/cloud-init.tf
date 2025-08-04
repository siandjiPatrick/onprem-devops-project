



resource "libvirt_cloudinit_disk" "cloudinit" {
  for_each = local.vm_envs_map
  name     = "${each.key}-cloudinit.iso"
  pool     = "default"

  user_data = templatefile("${path.module}/template/cloud-init/user-data.tmpl", {
    hostname   = "${each.value}"
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


  # meta_data = templatefile("${path.module}/template/cloud-init/meta-data.tmpl", {
  #   hostname    = each.value
  #   instance_id = each.value
  # })    

  # network_config = templatefile("${path.module}/template/cloud-init/network-config.tmpl", {
  #   ip_address = "192.168.122.${tonumber(split("-", each.key )) + 20 }"
  #   gateway    = "192.168.122.1"
  #   dns        = "8.8.8.8"
  #   interface  = "ens3"
  #   netmask    = "24"

  # })

  # meta_data = templatefile("${path.module}/template/cloud-init/meta-data.tmpl", {
  #   hostname    = "k8s-master"
  #   instance_id = "k8s-master"
  # })

  # network_config = templatefile("${path.module}/template/cloud-init/network-config.tmpl", {
  #   ip_address = "192.168.122.23"
  #   gateway    = "192.168.122.1"
  #   dns        = "8.8.8.8"
  #   interface  = "ens3"
  #   netmask    = "24"
  # })


}
