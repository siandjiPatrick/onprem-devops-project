

output "Vm_addresse" {
    depends_on = [ libvirt_domain.vm ]
    value = {
               for k, vm  in libvirt_domain.vm:    
                        k => vm.network_interface[0].addresses[0]
            }

    }
