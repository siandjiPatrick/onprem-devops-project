resource "libvirt_volume" "vm_disk" {
  for_each = {for env in var.deploy_environment : var.deploy_environment.key => env}

  name   = "${var.disk_name}_${each.key}.${var.disk_format}"
  pool   = var.disk_pool
  source = var.disk_source
  format = var.disk_format
}