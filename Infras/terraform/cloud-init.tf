resource "libvirt_cloudinit_disk" "cloudinit" {
  name      = "cloudinit.qcow2"
  pool      = "default"
  user_data = file("${path.module}/cloud-init/user-data")
}