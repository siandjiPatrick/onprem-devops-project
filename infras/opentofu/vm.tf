
resource "libvirt_domain" "vm" {

  for_each = local.all_vm_instances_map


  name   = each.key
  memory = var.VM_memory
  vcpu   = var.Vm_vcpu

  disk {
    volume_id = libvirt_volume.vm_disk[each.key].id
  }

  network_interface {
    network_name = var.Vm_network_properties.name
    #model       = var.Vm_network_properties.model
  }

  cloudinit = libvirt_cloudinit_disk.cloudinit.id

  console {
    type        = var.Vm_console_properties.type
    target_type = var.Vm_console_properties.target_type
    target_port = var.Vm_console_properties.target_port
  }

  graphics {
    type        = var.Vm_graphics_properties.type
    autoport    = var.Vm_graphics_properties.autoport
    listen_type = var.Vm_graphics_properties.listen_type
  }
}