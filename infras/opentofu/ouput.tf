

output "vm_ip_addresse" {
    depends_on = [ libvirt_domain.vm ]
    value = {
               for env, vm  in libvirt_domain.vm:    
                        env => vm.network_interface[0].addresses[0]
            }

    }
