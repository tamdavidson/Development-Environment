################################################
# R&D servers terraform deployed test
################################################

#####
# create vswitch that port group will connect to
#####
resource "esxi_vswitch" "deployed-vswitch" {
  name = "deployed-vswitch"
  uplink {
    name = "vmnic2"
  }
}

#####
# create port group that VMs will connect to
# this is a virtual network for resources
#####

resource "esxi_portgroup" "deployed-portgroup" {
  name = "deployed-portgroup"
  vswitch = esxi_vswitch.deployed-vswitch.name

}

#####
# create VM guest with local (esxi host) OVF/OVA file
#####

###
# Domain Controller VM ( OS to be specified )
###

resource "esxi_guest" "deployed-vm-001-DCC" {
  
  #required configuration
  guest_name = "deployed-vm-001-DC"
  disk_store = "datastore1"
  
  #optional configuration
  power = "off"

  network_interfaces {
    virtual_network = esxi_portgroup.deployed-portgroup.name
  }
}

###
# Windows 11 VM
###

resource "esxi_guest" "deployed-vm-002-WIN11" {

  #required configuration
  guest_name = "deployed-vm-002-WIN11"
  disk_store = "datastore1"

  #optional configuration
  power = "off"

  network_interfaces {
    virtual_network = esxi_portgroup.deployed-portgroup.name
  }
}

###
# Windows 10 VM
###

resource "esxi_guest" "deployed-vm-003-WIN10" {

  #required configuration
  guest_name = "deployed-vm-003-WIN10"
  disk_store = "datastore1"
  
  #optional configuration
  power = "off"
  
  network_interfaces {
    virtual_network = esxi_portgroup.deployed-portgroup.name
  }
  
}

###
# Windows 7 VM
###

resource "esxi_guest" "deployed-vm-004-WIN7" {

  #required configuration
  guest_name = "deployed-vm-004-WIN7"
  disk_store = "datastore1"

  #optional configuration
  power = "off"

  network_interfaces {
    virtual_network = esxi_portgroup.deployed-portgroup.name
  }
}

###
# Windows XP VM
###

resource "esxi_guest" "deployed-vm-005-WINXP" {

  #required configuration
  guest_name = "deployed-vm-005-WINXP"
  disk_store = "datastore1"

  #optional configuration
  power = "off"
  
  network_interfaces {
    virtual_network = esxi_portgroup.deployed-portgroup.name
  }
}

###
# Ubuntu (LINUX) VM
###

resource "esxi_guest" "deployed-vm-006-ubuntu" {

  #required configuration
  guest_name = "deployed-vm-006-ubuntu"
  disk_store = "datastore1"

  #optional configuration
  power = "off"
  
  network_interfaces {
    virtual_network = esxi_portgroup.deployed-portgroup.name
  }
}

###
# Centos OS VM
###

resource "esxi_guest" "deployed-vm-007-Centos" {

  #required configuration
  guest_name = "deployed-vm-007-Centos"
  disk_store = "datastore1"

  #optional configuration
  power = "off"
  
  network_interfaces {
    virtual_network = esxi_portgroup.deployed-portgroup.name
  }
}

###
# Windows Server 2012 VM
###

resource "esxi_guest" "deployed-vm-008-WINSRV12" {

  #required configuration
  guest_name = "deployed-vm-008-WINSRV12"
  disk_store = "datastore1"

  #optional configuration
  power = "off"
  
  network_interfaces {
    virtual_network = esxi_portgroup.deployed-portgroup.name
  }
}

###
# Windows Server 2016 VM 
###

resource "esxi_guest" "deployed-vm-009-WINSRV16" {

  #required configuration
  guest_name = "deployed-vm-009-WINSRV16"
  disk_store = "datastore1"

  #optional configuration
  power = "off"
  
  network_interfaces {
    virtual_network = esxi_portgroup.deployed-portgroup.name
  }
}

###
# Windows Server 2019 VM 
###

resource "esxi_guest" "deployed-vm-010-WINSRV19" {

  #required configuration
  guest_name = "deployed-vm-010-WINSRV19"
  disk_store = "datastore1"

  #optional configuration
  power = "off"
  
  network_interfaces {
    virtual_network = esxi_portgroup.deployed-portgroup.name
  }
}

###
# Velociraptor Server VM 
###

resource "esxi_guest" "deployed-vm-011-VELO" {

  #required configuration
  guest_name = "deployed-vm-011-VELO"
  disk_store = "datastore1"

  #optional configuration
  power = "off"
  
  network_interfaces {
    virtual_network = esxi_portgroup.deployed-portgroup.name
  }
}

###
# DFIR TCD VM 
###

resource "esxi_guest" "deployed-vm-012-DFIR" {

  #required configuration
  guest_name = "deployed-vm-012-DFIR"
  disk_store = "datastore1"

  #optional configuration
  power = "off"
  
  network_interfaces {
    virtual_network = esxi_portgroup.deployed-portgroup.name
  }
}

###
# Firewall VM 
###

resource "esxi_guest" "deployed-vm-013-FW" {

  #required configuration
  guest_name = "deployed-vm-013-FW"
  disk_store = "datastore1"

  #optional configuration
  power = "off"
  
  network_interfaces {
    virtual_network = esxi_portgroup.deployed-portgroup.name
  }
}