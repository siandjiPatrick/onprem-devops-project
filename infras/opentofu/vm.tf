
resource "libvirt_domain" "vm" {

  for_each = local.vm_envs_map


  name   = format("%s-%s", var.vm_config[split("-", each.key)[0]].name, each.key)
  memory = var.vm_config[split("-", each.key)[0]].memory
  vcpu   = var.vm_config[split("-", each.key)[0]].vcpu
  

  disk {
    volume_id = libvirt_volume.vm_disk[each.key].id
  }

  /* disk {
    volume_id = libvirt_volume.data_disk[each.key].id
  }*/

  network_interface {
    network_name = var.vm_config[split("-", each.key)[0]].network_properties.name
  }

  cloudinit = libvirt_cloudinit_disk.cloudinit[each.key].id

  console {
    type        = var.vm_config[split("-", each.key)[0]].console_properties.type
    target_type = var.vm_config[split("-", each.key)[0]].console_properties.target_type
    target_port = var.vm_config[split("-", each.key)[0]].console_properties.target_port
  }

  graphics {
    type        = var.vm_config[split("-", each.key)[0]].graphics_properties.type
    autoport    = var.vm_config[split("-", each.key)[0]].graphics_properties.autoport
    listen_type = var.vm_config[split("-", each.key)[0]].graphics_properties.listen_type
  }
}
