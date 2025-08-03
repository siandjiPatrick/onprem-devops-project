



resource "libvirt_cloudinit_disk" "cloudinit" {
  for_each = local.vm_envs_map
  name      = "${each.key}-cloudinit.iso"
  pool      = "default"
  
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
      ssh_authorized_keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCsMMYnVlyZIOfBxzGB49EMxIYNFuR4sNYrAxCkVg02Gxjpq590agQYesmjcKJkjnZPr5kQrQwdZU7XZoGgRY2y//H0Uo9IB7NtcKb6oUjqJzL76pEQ75FSAazKosIJgoFj7YDpoQpgaVmwOUg37QCtlTxUNbFAMmo8sw1FNUCIHeZbfK805LPPys8rRpw5+feX68EkpSx5PTL79BgD7c4MRbaK55kJEZJVgeCUv6yx0692D8os0FDI1oMG3pH080WcMlKQoqF5T/6INNt7pQVsS1m8ix4mifaki1QAZg/MpLmqkm2u+pHeLgFrDYRwahIu2pzhza5/nifkvltsgL4iDWO7Dd/kUHDowoImfgkAa6fPi7AEkid2aKv7UMUYQYQZMipEfhckYuwhpBqh8C+BAXvke3YPckJnmVbS3JbErHTdgmNXNdvnou0acnUxBxIfv6jlE3xEen2FihD9ruCAHSp1tvQhuhO2meo2pPgl7Z/vK/QQi21EBdvrQckwl5M= patrick@patrick-ubuntu-legion"]
    }
  ]

  packages_to_install = var.vm_config[split("-", each.key)[0]].user_data_properties.packages
  run_command         = var.vm_config[split("-", each.key)[0]].user_data_properties.runCommand
})

  #user_data = file("${path.module}/template/cloud-init/user-data.yaml")

}
