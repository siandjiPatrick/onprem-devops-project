resource "libvirt_volume" "vm_disk" {
  for_each = local.all_vm_env_map



  name   = "${var.disk_name}-${each.key}.${var.disk_format}"
  pool   = var.disk_pool
  source = "${path.module}/../../../images/${var.disk_source}" #qemu-img resize /chemin/vers/ton-disque.qcow2 +10G

  format = var.disk_format
 
}

# Create a second empty disk (data)
resource "libvirt_volume" "data_disk" {
  for_each = local.all_vm_env_map

  name   = "vm-data-${each.key}.${var.disk_format}"
  pool   = var.disk_pool
  size   = 5 * 1024 * 1024 * 1024  # 5 GiB
  format = "qcow2"
}