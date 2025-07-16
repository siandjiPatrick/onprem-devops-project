terraform{
  required_providers{
    libvirt = {
            source = "dmacvicar/libvirt"
            version = "0.8.3"
    }
  }
}

# Configure the Libvirt provider
provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_domain" "vm" {
  name   = "test"
  memory = 1024
  vcpu   = 1

  disk {
    volume_id = libvirt_volume.vm_disk.id
  }

  network_interface {
    network_name = "default"
    #model        = "virtio"
  }

  cloudinit = libvirt_cloudinit_disk.cloudinit.id

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type        = "vnc"
    autoport    = true
    listen_type = "address"
  }
}


resource "libvirt_volume" "vm_disk" {
  name   = "test.qcow2"
  pool   = "default"
  source = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
  format = "qcow2"
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  name      = "cloudinit.iso"
  pool      = "default"
  user_data = file("${path.module}/cloud-init/user-data")
}


