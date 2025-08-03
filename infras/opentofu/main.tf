/*locals {
  all_vm_instances_list = flatten([
    for env, config in var.vm_config: [
      for i in range(config.number_instance) : {
        name  = "${env}_Server_${i+1}"
        env   = env
        index = i
      }
    ]
  ])
}

locals {
  all_vm_disks_name= flatten(
                        [ for env, config in var.vm_config:
                                [for i in range(config.number_instance):
                                    {
                                        vm_disk_name = "${env}_${var.disk_name}_${i+1}"
                                    }

                                ]
                        
                        ])
}  

locals {
  vm_disks_map = {
    for item in local.all_vm_disks_name :
    item.vm_disk_name => item
  }
}

locals {
  all_vm_instances_map = {
    for vm in local.all_vm_instances_list :
    vm.name => {
      env   = vm.env
      index = vm.index
    }
  }
}
*/