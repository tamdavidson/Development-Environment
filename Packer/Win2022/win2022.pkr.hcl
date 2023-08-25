packer {
  required_plugins {
    vmware = {
      source  = "github.com/hashicorp/vmware"
      version = "~> 1"
    }
  }
}
###START###
//ESXi host variables
//remote esxi type
variable "esxi_type" {
    type = string
    default = "esx5"
}

//remote esxi machine IP or host name
variable "esxi_host" {
  type    = string
  default = ""
}

// remote machine port for connection SSH
variable "esxi_port" {
    type = string
    default =   ""
}

// remote datastore that will be used to create vm image  
variable "esxi_datastore" {
  type    = string
  default = ""
}

// remote directory that will contain iso file for image
variable "esxi_iso_directory" {
  type    = string
  default = ""
}

//remote output diretory
variable "esxi_output_directory"{
    type = string
    default = ""
}

variable "esxi_username" {
  type    = string
  default = ""
}

/* will need to remove password before commit */
// user on remote machine password
variable "esxi_password" {
  type      = string
  default   = ""
  sensitive = true // will be omitted from packer output
}

###END###

variable "boot_wait" {
  type    = string
  default = "5s"
}

variable "disk_size" {
  type    = string
  default = "40960"
}

variable "iso_checksum" {
  type    = string
  default = "4F1457C4FE14CE48C9B2324924F33CA4F0470475E6DA851B39CCBF98F44E7852"
}

variable "iso_url" {
  type    = string
  default = "https://software-download.microsoft.com/download/sg/20348.169.210806-2348.fe_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso"
}

variable "memsize" {
  type    = string
  default = "2048"
}

variable "numvcpus" {
  type    = string
  default = "2"
}

variable "vm_name" {
  type    = string
  default = "Win2022_20324_test"
}

variable "winrm_password" {
  type      = string
  default   = "packer"
  sensitive = true
}

variable "winrm_username" {
  type    = string
  default = "Administrator"
}

source "vmware-iso" "win2022_base" {
  boot_wait              = "${var.boot_wait}"
  communicator           = "winrm"
  disk_size              = "${var.disk_size}"
  floppy_files           = ["scripts/bios/gui/autounattend.xml"]
  guest_os_type          = "windows2019srv-64"
  headless               = false
  insecure_connection    = true
  iso_checksum           = "${var.iso_checksum}"
  iso_url                = "${var.iso_url}"
  
  network_adapter_type   = "E1000e"
  network_name           = "VM Network"
  shutdown_command       = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout       = "30m"
  vm_name                = "${var.vm_name}"
  vmx_data = {
    memsize             = "${var.memsize}"
    numvcpus            = "${var.numvcpus}"
    "scsi0.virtualDev"  = "lsisas1068"
    "virtualHW.version" = "14"
  }
  
  winrm_insecure       = true
  winrm_password       = "${var.winrm_password}"
  winrm_timeout        = "4h"
  winrm_use_ssl        = true
  winrm_username       = "${var.winrm_username}"
  // remote variables
  remote_cache_datastore  = "${var.esxi_datastore}"
  remote_cache_directory  = "${var.esxi_iso_directory}"
  remote_datastore        = "${var.esxi_datastore}"
  remote_host             = "${var.esxi_host}"
  remote_password         = "${var.esxi_password}"
  remote_port             = "${var.esxi_port}"
  remote_type             = "${var.esxi_type}"
  remote_username         = "${var.esxi_username}"
  remote_output_directory = "${var.esxi_output_directory}"
  skip_export          = false
  format = "ovf"
  vnc_disable_password = true
  vnc_over_websocket   = true
  keep_registered = true
  ovftool_options = ["--overwrite"]
  //
}

build {
  sources = ["source.vmware-iso.win2022_base"]

  provisioner "powershell" {
    pause_before = "1m0s"
    scripts      = ["scripts/vmware-tools.ps1"]
  }

  provisioner "powershell" {
    scripts = ["scripts/setup.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

## commented out windows update to spend up install process ##
 # provisioner "powershell" {
 #   scripts = ["scripts/win-update.ps1"]
 # }
#
 # provisioner "windows-restart" {
 #   restart_timeout = "30m"
 # }
#
 # provisioner "powershell" {
 #   scripts = ["scripts/win-update.ps1"]
 # }
#
 # provisioner "windows-restart" {
 #   restart_timeout = "30m"
 # }

  provisioner "powershell" {
    pause_before = "1m0s"
    scripts      = ["scripts/cleanup.ps1"]
  }

}
