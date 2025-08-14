

locals {
  # 1. Liste plate de VMs avec nom + ansible_config
  all_vm_ip_adresss = [
    for env, vm in libvirt_domain.vm : {
      env_name = env
      ansible_config =  try("ansible_host=${vm.network_interface[0].addresses[0]} ansible_user=${var.vm_config[split("-", env)[0]].user_data_properties.user_name}", "${var.info_message}")
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

  # Liste des k8s masters : prod-1 uniquement
  k8s_masters = [
    for env in local.grouped_hosts["prod"] : env
    if env == "prod-1"
  ]

  # Liste des k8s workers : tous sauf prod-1
  k8s_workers = [
    for env in local.grouped_hosts["prod"] : env
    if env != "prod-1"
  ]


  inventory = templatefile("${path.module}/template/ansible/inventory.tmpl", {
    groups = local.grouped_hosts
    hosts = local.all_vm_ip_adresss
    k8s_masters  = local.k8s_masters
    k8s_workers  = local.k8s_workers

  
  })
}


resource "local_file" "ansible_inventories" {
  depends_on = [ libvirt_domain.vm ]
  content  = local.inventory
  filename = "${path.module}/../../config/ansible/inventory.ini"
}



