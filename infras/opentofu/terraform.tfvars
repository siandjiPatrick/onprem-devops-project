vm_config = {
  #Bacca
  dev = {
    number_instance = 1
    name            = "server"
    memory          = 2048
    vcpu            = 2
    network_properties = {
      type = "virtio"
      name = "default"
    }
    console_properties = {
      type        = "pty"
      target_type = "serial"
      target_port = "0"
    }
    graphics_properties = {
      type        = "vnc"
      autoport    = true
      listen_type = "address"
    }
    disk = {
      name   = "os-disk"
      pool   = "default"
      source = "/var/lib/libvirt/images/ubuntu-cloud.img"
      format = "qcow2"
    }
    user_data_properties = {
      hostname                 = "dev-server"
      user_name                = "dev"
      user_shell               = "/bin/bash"
      user_password            = "$6$BkAAbLRRpYUJczhX$dENZP7lCcxo3ntWRq5r3NcbpSCOz.zw21umrYBp6RD1LDttBuTopWTjO0tKprQSgPArQssuGxG54sHWkF/HqZ/"
      lock_password            = false
      user_groups              = "users, admin"
      ssh_authorized_keys_path = "~/.ssh/id_rsa.pub"
      ssh_passAuthentification = true
      packages                 = []
      runCommand = [
        "localectl set-keymap de",
      "localectl set-x11-keymap de nodeadkeys"]
      ansible_port = 8081
      info_message = "willkommen"
    }
  },
  #Preprod
  preprod = {
    number_instance = 1
    name            = "server"
    memory          = 2048
    vcpu            = 2
    network_properties = {
      type = "virtio"
      name = "default"
    }
    console_properties = {
      type        = "pty"
      target_type = "serial"
      target_port = "0"
    }
    graphics_properties = {
      type        = "vnc"
      autoport    = true
      listen_type = "address"
    }
    disk = {
      name   = "os-disk"
      pool   = "default"
      source = "/var/lib/libvirt/images/ubuntu-cloud.img"
      format = "qcow2"
    }
    user_data_properties = {
      hostname                 = "preprod-server"
      user_name                = "preprod"
      user_shell               = "/bin/bash"
      user_password            = "$6$sU2auG6i7lgcqKRF$KtlG2nc.7c//ALX8q4nd5JXDhv2vx8to98wlKcO7otHHt7dbvuqhwipfyZTr/OhZ0F5nt6YdCqs0V/8BkP2U9/"
      lock_password            = false
      user_groups              = "users, admin"
      ssh_authorized_keys_path = "~/.ssh/id_rsa.pub"
      ssh_passAuthentification = true
      packages                 = []
      runCommand = [
        "localectl set-keymap de",
        "localectl set-x11-keymap de nodeadkeys"

      ]
      ansible_port = 8081
      info_message = "willkommen preprod-user"
    }

  },
  #production
  prod = {
    number_instance = 3
    name            = "server"
    memory          = 2048
    vcpu            = 2
    network_properties = {
      type = "virtio"
      name = "default"
    }
    console_properties = {
      type        = "pty"
      target_type = "serial"
      target_port = "0"
    }
    graphics_properties = {
      type        = "vnc"
      autoport    = true
      listen_type = "address"
    }
    disk = {
      name   = "os-disk"
      pool   = "default"
      source = "/var/lib/libvirt/images/ubuntu-cloud.img"
      format = "qcow2"
    }
    user_data_properties = {
      hostname                 = "prod-server"
      user_name                = "prod"
      user_shell               = "/bin/bash"
      user_password            = "$6$sKwnWBiWrT7Vdbn9$kgdMAuO1.NSyUveHfA8t0gmJ/HEqBR/bbo1lEoXtI2fX3Zex4IShJysM2dGmBrNCtviLd9GrESG3NPAt.e.zp/"
      lock_password            = false
      user_groups              = "users, admin"
      ssh_authorized_keys_path = "~/.ssh/id_rsa.pub"
      ssh_passAuthentification = true
      packages                 = ["curl", "git"]
      runCommand = [
        "localectl set-keymap de",
        "localectl set-x11-keymap de nodeadkeys",
      ]
      ansible_port = 8081
      info_message = "willkommen prod user"
    }

  }
}


