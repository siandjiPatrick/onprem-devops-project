resource "local_file" "ansible_inventories" {
  #for_each = toset(local.env_list)
  for_each = local.all_vm_env_map

  content  = <<EOF
  [${each.key}]
  ${libvirt_domain.vm["${each.key}"].network_interface[0].addresses[0]}
            
  
  
  EOF
  filename = "${path.module}/../ansible/inventory.ini"
}