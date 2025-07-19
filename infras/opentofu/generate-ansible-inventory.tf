

locals {
  all_vm_ip_adresss= {
    for env, vm in libvirt_domain.vm :
      env => vm.network_interface[0].addresses[0]
      
  }

  inventory = templatefile("${path.module}/template/ansible/inventory.tmpl",
                          {
                            all_vm_ip_adress = local.all_vm_ip_adresss
                          })
}



resource "local_file" "ansible_inventories" {
  depends_on = [ libvirt_domain.vm ]
  content  = local.inventory
  filename = "${path.module}/../ansible/inventory.ini"
}
