
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ VM Information @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

variable "vm_config" {
  type = map(object({
    number_instance = number
    name            = string
    #  ------------- VM  VCPU and Memory -----------------------
    memory = number
    vcpu   = number

    #  ------------- VM Network Informations ------------------
    network_properties = object({
      type = string
      name = string
    })

    #  ------------- VM Console Informations ------------------
    console_properties = object({
      type        = string
      target_type = string
      target_port = string
    })

    #  ------------- VM Graphics Informations -----------------
    graphics_properties = object({
      type        = string
      autoport    = bool
      listen_type = string
    })

    #  ------------- VM Disk Informations ----------------------
    disk = object({
      name   = string
      pool   = string
      source = string
      format = string
    })

    #  ------------- VM Cloud Init Informations ------------------
    user_data_properties = object({
      hostname      = string
      user_name     = string
      user_shell    = string
      user_password = string
      lock_password = bool
      user_groups   = string

      ssh_authorized_keys_path = string
      ssh_passAuthentification = bool

      packages = list(string)

      runCommand   = list(string)
      ansible_port = number
      info_message = string
    })
    }
  ))
}

variable "info_message" {
  type    = string
  default = "Warten !!! "
}