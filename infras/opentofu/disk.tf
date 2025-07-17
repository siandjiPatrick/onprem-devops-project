resource "libvirt_volume" "vm_disk" {
  for_each = local.all_vm_instances_map



  name   = "${each.key}.${var.disk_format}"
  pool   = var.disk_pool
  source = var.disk_source
  format = var.disk_format
}