# Domain Name System

Phonebook of the internet

- Go to Server Manager, Tools, DNS
- DNS at the top left is the remote DNS, you can connect if you have
- The one we have on our Server is listed below
- Right click on DNS Server name (MYDC01) and 
click Launch nslookup
- try entering WS01 to lookup
- see the resultin domain name and IP address
- then right click on DNS Server MYDC01 and All Tasks, Stop
- This will stop the DNS server
- Now give the same command to lookup for domain names, see that the server does not respond

- hosts file is used to map IP addresses to an easy-to-remember name
- stay on windows server
- you can find it on windows/system32/drivers/etc folder on
- open hosts file with notepad 
- observe the file
- open cmd and type "ping test"
- see the result
- open hosts file and create an entry like this at the bottom
127.0.0.1 test
- save and quit
- open cmd and then type "ping test" again
- open hosts file and delete the entry
- type ping test again
- remember that hosts file is only effective on the host computer

* DNS Zone
- A DNS Zone is a collection of DNS records
- Records map IP addresses to names
-- Forward Lookup Zone
translate Host name to IP
-- Reverse Lookup Zone
translate IP to Host name

- Create Reverse Lookup Zone and create a PTR record

- go to cmd and type "nslookup techprodevops.com"
- nslookup ws01
- nslookup mydc01
- see that the IP address is resolved, this is forward lookup

- type "nslookup 127.0.0.1"
- type "nslookup 192.168.0.10"
- see that the hostname (domain name) is resolved, this is reverse lookup

- Primary DNS Zone primary source of record information
- Secondary DNS Zone is read-only replica of Primary DNS Zone
- Stub DNS Zone contains information about authoritative name servers, is read-only

Record Types
SOA (Start of Authority)
every zone has
contains information about DNS server

NS (Name Server)
every zone has
indicates zone authoritative DNS server

A (Address) Record
maps a domain name to an IP address
fs01.techpro.com > 192.168.0.201

PTR (pointer) Record
maps an IP address to a domain
192.168.0.200 > dc01.techpro.com

CNAME (canonical) Record
creates an alias for a domain
machine.techpro.com > ws01.techpro.com

MX (mail exchange)