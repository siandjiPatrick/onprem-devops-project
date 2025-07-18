resource "libvirt_volume" "vm_disk" {
  for_each = local.all_vm_env_map



  name   = "${var.disk_name}-${each.key}.${var.disk_format}"
  pool   = var.disk_pool
  source = "${path.module}/images/${var.disk_source}"
  format = var.disk_format
  #size = 10737418240
}