#!/bin/bash

set -e

select_interface() {  
  echo "Select the number of the interface that you want to reset the IP address"
  select INTERFACE in $(ifconfig -l); do
     echo "You picked interface $INTERFACE ($REPLY) to reset"
     [[ -n $INTERFACE ]] || { echo "Invalid choice, try again." >&2; continue; }
     break # a valid choice was made, exit the prompt,
  done
}

reset_interface() {
   local interface_name=$1

   echo "starting the reset of interface ${interface_name}...."

   local ip=$(ipconfig getifaddr ${interface_name})
   local subnet=$(ipconfig getoption ${interface_name} subnet_mask)
   local dhcp_set=$(ipconfig getpacket ${interface_name})

   if [ -z "${ip}" ]; then
	echo "no ip on interface ${interface_name}, exiting"
	exit 1
   else
	echo "deleting ip address ${ip} on interface ${interface_name}...."
	ifconfig ${interface_name} delete ${ip}
	echo "deleted ip address ${ip} on interface ${interface_name}"
   fi

   if [ -z "${dhcp_set}" ]; then
   	ipconfig set ${interface_name} manual ${ip} ${subnet}
   else
	ipconfig set ${interface_name} dhcp
   fi

   echo "successfully reset ip of interface ${interface_name}"
}


check_running_as_sudo() {
  if [ "${EUID}" -ne 0 ]; then
    echo "Please run as sudoer/root"
    exit
  fi
}

main() {
  check_running_as_sudo
  select_interface
  reset_interface ${INTERFACE}
}

main
