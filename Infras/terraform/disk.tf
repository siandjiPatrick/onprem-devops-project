resource "libvirt_volume" "vm_disk" {
  name   = "${var.disk_name}.${var.disk_format}"
  pool   = var.disk_pool
  source = var.disk_source
  format = var.disk_format
}