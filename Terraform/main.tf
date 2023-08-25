################################################
# R&D servers terraform deployed test
################################################
#
#   Use of variables here to hide/move the variables to a separate file
#
provider "esxi" {
  esxi_hostname = var.esxi_hostname
  esxi_hostport = var.esxi_hostport
  esxi_hostssl  = var.esxi_hostssl
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

#####
# Resource Virtual Switch - will be used to connect to the internet during provision stage
#####
resource "esxi_vswitch" "deployed-vswitch" {
  name = "deployed-vswitch"
  uplink {
    name = "vmnic2"
  }
}

#####
# Resource port group - will be connected to the switch above
#####

resource "esxi_portgroup" "deployed-portgroup" {
  name = "deployed-portgroup"
  vswitch = esxi_vswitch.deployed-vswitch.name

}

####
# Resource Esxi_Guest - Windows Server 2022
####
resource "esxi_guest" "Windows_Server_2022" {
  count = var.win2022_count 
  guest_name = "${var.vm_name_prefix}_win2022_${count.index}"
  disk_store = "datastore1"
  numvcpus = 2
  memsize = 2048
  #local ovf stored in Development-enviroment folder // relative or absolute 
  ovf_source = "..\\Packer\\Win2022\\output-win2022_base\\Win2022_20324_test.ovf"
  power = "on"
  #connect to virtual switch  
  network_interfaces {
    virtual_network = esxi_portgroup.deployed-portgroup.name
    nic_type = "e1000e"
  }
}
####
# Resource Esxi_Guest - Windows 10 Host
####
resource "esxi_guest" "Windows_10" {
  count = var.win10_count
  guest_name = "${var.vm_name_prefix}_win10_${count.index}"
  disk_store = "datastore1"
  numvcpus = 2
  memsize = 2048
  #local ovf stored in Development-enviroment folder // relative or absolute 
  ovf_source = "..\\Packer\\Win10\\output-Win10_base\\Win10_1809.ovf"
  power = "on"
  #connect to virtual switch  
  network_interfaces {
    virtual_network = esxi_portgroup.deployed-portgroup.name
    nic_type = "e1000e"
  }
}

