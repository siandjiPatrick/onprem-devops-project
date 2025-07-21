

locals {
  # 1. Liste plate de VMs avec nom + ansible_config
  all_vm_ip_adresss = [
    for env, vm in libvirt_domain.vm : {
      env_name = env
      ansible_config       = "${vm.network_interface[0].addresses[0]} ansible_port=${var.ansible_port} ansible_user=${var.cloudInit_ansible_user_name} ansible_ssh_private_key_file=${var.ansible_ssh_private_key_file_path}"

    }
  ]

  # 2. Groupement des ansible_configs par préfixe d’environnement (prod, preprod, etc.)
  grouped_hosts = {
    for prefix in distinct([
      for vm in local.all_vm_ip_adresss : split("-", vm.env_name)[0]
    ]) :
    prefix => [
      for vm in local.all_vm_ip_adresss :
      "${vm.env_name}"
      #"${vm.env_name} ansible_host=${vm.ansible_config}"
      if split("-", vm.env_name)[0] == prefix
    ]
  }




  inventory = templatefile("${path.module}/template/ansible/inventory.tmpl", {
    groups = local.grouped_hosts
    hosts = local.all_vm_ip_adresss

  
  })
}


resource "local_file" "ansible_inventories" {
  depends_on = [ libvirt_domain.vm ]
  content  = local.inventory
  filename = "${path.module}/../ansible/inventory.ini"
}


output "grouped_hosts" {
  value = local.grouped_hosts
}
