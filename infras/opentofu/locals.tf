locals {
  vm_envs_list = flatten([
    for env, config in var.vm_config: [
      for i in range(config.number_instance) : {
        env_name  = "${env}-${i+1}"
        env = "${env}"
      }
    ]
  ])

  # convert to map
  vm_envs_map = {
    for vm in local.vm_envs_list :
    vm.env_name => vm
  }
  
  env_list = [ for env, config in var.vm_config:  env ]
}

