locals {
  all_vm_env_list = flatten([
    for env, config in var.Vm_pro_environment : [
      for i in range(config.number_vm) : {
        env_name  = "${env}-${i+1}"
      }
    ]
  ])

  # convert to map
  all_vm_env_map = {
    for vm in local.all_vm_env_list :
    vm.env_name => vm
    
  }
}




locals{
  env_list = [ for env, config in var.Vm_pro_environment:  env ]
}


