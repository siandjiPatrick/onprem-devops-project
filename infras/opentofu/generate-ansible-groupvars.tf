

locals {
  group_vars = templatefile("${path.module}/template/ansible/global_vars.tmpl", {
    ansible_port = var.ansible_ssh_port
    ansible_ssh_private_key_file = var.ansible_ssh_private_key_file_path

  
  })
}


resource "local_file" "ansible_global_vars" {
  depends_on = [ libvirt_domain.vm ]
  content  = local.group_vars
  filename = "${path.module}/../ansible/group_vars/all.yaml"
}



