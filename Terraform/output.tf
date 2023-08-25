# output of instance IP

output "guest_name" {
  description = "guest name of each virtual machine"
  value = ["${flatten(tolist(
    [esxi_guest.Windows_10.*.guest_name, 
    esxi_guest.Windows_Server_2022.*.guest_name]
  ))}"]
}

output "ipaddress" {
    description = "IP Address of all hosts"
    value = "${flatten(tolist([
    esxi_guest.Windows_10.*.ip_address, 
    esxi_guest.Windows_Server_2022.*.ip_address
    ]))}"
}