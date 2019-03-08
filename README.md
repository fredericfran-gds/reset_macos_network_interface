# Reset MACOS Network Interface Utility

Simple bash script to reset the network interface on MACOS which is 
useful if you want to restore your network connectivity to your
VirtualBox virtual machine after connecting to CISCO VPN.

## How this utility works

Basch script will do the following based on whether:

1. network interface was set manually
    1. the original IPv4 address and subnet is retrieved from the interface
    2. the IPv4 address is removed from the interface
    3. the IPv4 address and subnet is applied back onto the interface
   
2. network interface was set via DHCP
    1. the original IPv4 address and subnet is retrieved from the interface
    2. the IPv4 address is removed from the interface
    3. the interface is triggered to get a new IPv4 address via DHCP

## How to use

Steps:

1. clone this repo to your mac

2. make the bash script executable:
   ```
    chmod +x reset_macos_inet.sh
   ```

3. run the script as sudoer 
   (this is required because you are making system modifications):
   ```
    sudo ./reset_macos_inet.sh   
   ```

4. select the index of the network interface that you want to reset from
   the list displayed
