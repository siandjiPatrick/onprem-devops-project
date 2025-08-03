locals {
  vm_envs_list = flatten([
    for env, config in var.vm_config : [
      for i in range(config.number_instance) : {
        env_name = "${env}-${i + 1}"
        env      = "${env}"
      }
    ]
  ])

  # convert to map
  #vm_envs_map = {
  #  for vm in local.vm_envs_list :
  #  vm.env_name => vm
  #}

   vm_envs_map = {
    for vm in local.vm_envs_list :
    vm.env_name => (
      vm.env_name == "prod-1" ? 
        "k8s-master" :
      startswith(vm.env_name, "prod-") ?
        "k8s-worker${tonumber(split("-", vm.env_name)[1]) - 1}" :
        vm.env_name
    )
  }
  
  env_list = [for env, config in var.vm_config : env]
}

output "vm_envs_map" {
  value = local.vm_envs_map
  
}