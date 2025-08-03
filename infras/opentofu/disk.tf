resource "libvirt_volume" "vm_disk" {
  for_each = local.vm_envs_map

  name   = format("%s-%s.%s", var.vm_config[split("-", each.key)[0]].disk.name, each.key, var.vm_config[split("-", each.key)[0]].disk.format)
  pool   = var.vm_config[split("-", each.key)[0]].disk.pool
  source = var.vm_config[split("-", each.key)[0]].disk.source #qemu-img resize /chemin/vers/ton-disque.qcow2 +10G
  format = var.vm_config[split("-", each.key)[0]].disk.format

}


# Create a second empty disk (data)
resource "libvirt_volume" "data_disk" {
  for_each = local.vm_envs_map

  name   = format("%s-%s.%s", "hdd", each.key, var.vm_config[split("-", each.key)[0]].disk.format)
  pool   = var.vm_config[split("-", each.key)[0]].disk.pool
  size   = 5 * 1024 * 1024 * 1024 # 5 GiB
  format = var.vm_config[split("-", each.key)[0]].disk.format
}