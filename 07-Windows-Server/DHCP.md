# DHCP Server

* If your network settings on the VirtualBox appears as Host-only Network, you should uncheck DHCP Server checkbox

* If your network settings are as NatNetwork, then click edit settings and uncheck Supports DHCP checkbox

- DHCP Server sets dynamic IPs to the computers on the same network.
- DHCP sends DiscoveryOfferRequestAcknowledge

- Static IP use cases:
-- DNS Servers
-- Domain Controllers
-- Printers/scanners
-- Servers


- To be able to set DHCP on our Windows network we need to add a Server role as DHCP
- Open Server Manager, Manage, Add Roles And Features
- Select DHCP Server
- After Installation Post-Install Configuration should be made
- After configuration is made click Tools and then DHCP
- you will see the domain and under the domain IPv4 and IPv6 settings
- right click on IPv4 for a new scope
- set a name and description for the scope
- set start and end IP addresses
192.168.0.2 - 192.168.0.254
- Length and subnet masks are created automatically
- Add Exclusions for the Servers
192.168.0.2 - 192.168.0.25
- Lease Duration specifies how long a client can use IP address, leave as default
- Router (Default Gateway)
192.168.0.1
- Domain Name and DNS Servers, leave default
- WINS Servers, DNS replaces it, skip by clicking Next
- Click Activate DHCP Scope later
- A new scope appears on DHCP window
- Right click on Scope and click Activate
- Inspect the Scope settings
- go to a client computer
- open NIC settings and select DHCP
- open cmd and give those commands
- ipconfig /release
- ipconfig /renew