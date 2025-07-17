
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ VM Information @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
variable "Vm_name" {

  type = string
}

#  ------------- VM Memory Informations ------------------------------------------

variable "VM_memory" {

  type = number
}

#  ------------- VM  VCPU  --------------------------------------------------------

variable "Vm_vcpu" {

  type = number

}


#  ------------- VM Network Informations ------------------------------------------

variable "Vm_network_properties" {
  type = object(
    {
      type = string
      name = string
    }
  )


}


#  ------------- VM Console Informations ------------------------------------------

variable "Vm_console_properties" {
  type = object(
    {
      type        = string
      target_type = string
      target_port = string

    }
  )


}


#  ------------- VM Graphics Informations ------------------------------------------

variable "Vm_graphics_properties" {
  type = object(
    {
      type        = string
      autoport    = bool
      listen_type = string

    }
  )
}


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Disk Information @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

variable "disk_name" {
  type = string

}

variable "disk_pool" {
  type = string

}

variable "disk_source" {
  type = string

}

variable "disk_format" {
  type = string

}

variable "Vm_pro_environment" {
  type = map(object({
     number_vm = number
  }
  ))
}