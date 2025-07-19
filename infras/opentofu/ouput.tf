

output "vm_ip_addresse" {
    #depends_on = [ libvirt_domain.vm ]
    value = {
               for env, vm  in libvirt_domain.vm:    
                        env => vm.network_interface[0].addresses[0]
            }

    }

output "inventory" {
    value = local.inventory
  
}



output "env_list"{
  value = local.env_list
}


output "all_vm_ip_adresss"{
  value = local.all_vm_ip_adresss
}