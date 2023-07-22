# Windows Server

## Virtual Box Installation
- go to virtualbox downloads page, based on your OS download virtualbox and install 

https://www.virtualbox.org/wiki/Downloads

- configure virtualbox, set network and .iso windows image

## Install Windows Server using .iso on Virtual Box
- Select Datacenter Evaluation (GUI) at the beginning of installation
- Once the installation is complete you will be prompted to enter password for built-in Administrator account. Do not forget this password.

## Windows Server Management

- Install Virtual Box Guest Editions
In the Devices menu in the virtual machine's menu bar, Oracle VM VirtualBox has a menu item Insert Guest Additions CD Image, which mounts the Guest Additions ISO file inside your virtual machine. A Windows guest should then automatically start the Guest Additions installer, which installs the Guest Additions on your Windows guest.

documentation:
https://www.virtualbox.org/manual/ch04.html

- once installation is complete, choose to reboot later.

- open Server Manager

- Click Local Server
- see Computer Name, click the name, click Change, then enter a new name for Computer name, MYDC01 (my domain controller 01)
- Click OK
- Click Close to close properties window
- Click Restart Later
- On the same Local Server Properties Page, click Ethernet
- At the same time click cmd on the start menu and use command ipconfig to see your IP, and Default Gateway. check if they are on the same network

- Go back to Network Connections, right click on the Ethernet and click properties
- Uncheck IPv6
- click Internet Protocol IPv4, then properties
- enter the IP address 192.168.0.10
- press tab to complete mask
- enter default gateway 192.168.0.1 (we use default gateway to connect to other networks like internet)
- enter DNS server 192.168.0.10 as this machine will also be a dns server
- enter alternate DNS 8.8.8.8
- click Ok, and then Ok to close the dialog boxes
- go to cmd prompt to see ipconfig results again
- ping the gateway, and ping google dns 8.8.8.8
- see if you can ping
- now restart the server

## How to Use Windows Server

- Server Manager is used to manage this and other servers on your network

- First 3 on the Server Manager window are related to server or remote server
- 4th is a server role 
- If you install new roles and services they will appear here.

- Local Server Tab gives information about the server you are logged on to
- From here you can change the computer name, domain membership, firewall and network settings.
- Here, Events, Services, Roles and Features of the Local Server are listed

- All Servers Tab gives Events, Services info about the remote servers

- Roles and Features are key concepts for Windows Server

Role can be adding DHCP Role to our Server

Adding or Removing Roles and Features is done by Manage button at the top of Server Manager Window

Once you add a role to install, some features might also appear to company.

Every role you install will require Post-deployment configuration

## Windows Domain

- Allows administrators to manage large computer networks

Windows Domain Controller
- DC
- Server with AD DS (Active Directory Domain Services) role
- handles authentication requests across the domain 
- DC uses a tool AD users and computers
used to manage
-- user accounts
-- computers
-- printers 
-- file shares

AD contains objects:
-- users
-- computers
-- printers
-- file shares
-- groups

OU (organizational unit) is used to group objects

Group Policy Management
- manage all domain user and computer settings remotely
- GPO (Group Policy Object) is used to manage client settings
- target specific users, computers, groups or OUs
- install sofware remotely
- configure desktop background
- manage what website users can visit
- manage and configure security settings

### Create Windows Domain for AD DS

- Use Add Roles and Features Wizard

- Select and Install Active Directory Domain




What is a Windows Domain?
X A large or small number of computers managed by a Domain controller
A large number of printers managed by a single server
A large or small number of Windows Servers

Which of the following important tools are installed on a Windows Domain Controller by default?
X Active Directory Users and Computers
Key Management Service
Windows Server Update Services


What server role must be installed on a server in order for it to be considered a domain controller?
Group Policy Management
Active Directory Users and Computers
X Active Directory Domain Services (AD DS)

What is used to manage Windows Domains?
Domain Componenets
Domain Catalogs
X Domain Controllers
Domain Contracts

"Active Directory" and "Active Directory user and Computers" are the same thing.
True

Which of the following is not a valid Active Directory object?
User Account
File Share
X GPO
Group
Printer


# Install and Setup Windows 10 
- Create a new Virtualbox VM
- select the same nat network of Server
- select windows 10 iso image
- make installation
- installation should be done not using windows account!
- select joining a domain instead
- after installation install Guest Additions CD 
- After reboot make sure both Server and Windows 10 are running
- check properties and verify their network is the same
- login to Windows 10
- open cmd
- check ipconfig to see if they are on the same network
- if the network is not the same, go to settings, network&internet, change adapter options
- right click on ethernet and click properties
- uncheck IPv6 and selecting IPv4 click properties
-- specify IP as 192.168.0.100
-- Default gateway as 192.168.0.1
-- DNS server as 192.168.0.10 (the Server machine)
-- alternate DNS as 8.8.8.8 (google dns)

## Rename Windows 10 Machine and Join it to Domain
- Click Start menu and then settings button
- select system, go down to the bottom and select About 
- click rename this PC
- type WS01 (workstation01)
- click next and then click restart later
- search for connect to work or school
- click connect (+)
- then select from alternate actions
- click join this device to Active Directory
- type the domain name we entered at the server
- enter Administrator and password when prompted
- on the IP settings if DNS incorrectly set, we cannot connect to the domain
- skip the dialog asking to add account for this Windows 10 PC
- choose restart now

- leave windows 10 to restart and open windows server now

- go to Server Manager, Tools, Active Directory Users and Computers

- click domain name (techprodevops.com) then Computers
- you will notice WS01 as the name of the computer
- we verify that the Windows 10 machine joined the domain!!


What OU is a computer placed into by default when it is joined to a domain?
Workstations
X Computers
Laptops
Domain

What does a PING command do?
X Sends a message to a target host asking for a response
Sends a message to a target host


Regarding the TCP/IP settings of a domain workstation, what IP address should you configure for your DNS server settings?
The IP address of another workstation
X The IP address of a Domain Controller


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



* DHCP Reservation


What is a DHCP exclusion?
A single IP address that is not to be supplied to clients by DHCP
X A range of IP addresses that are not to be supplied to clients by DHCP


In regards to DHCP, what does the acronym D.O.R.A. stand for?
Discover, Offer, Request, Acknowledgement


How does a DHCP reservation identify with its target client machines?
IP address
X MAC address


What command can you run from Command Prompt to get a computers MAC address(es)?
X getmac
showmac


If you run an "ipconfig" command on a computer and you see an IP address of "169.254.155.74", what does this mean?
X The computer is configured for DHCP and could not find a DHCP server
The computer is connected to a DHCP Server


If a DHCP server crashes, when will the computers who are configured to rely on DHCP loose network connectivity?
Immediately
X When their leases expire


How many DHCP scopes can you have on a single subnet?
X One
Four


DHCP allows you to configure settings like DNS Servers, Routers (default gateways), and Domain name.
True




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
ws01.techprodevops.com > 192.168.0.100

PTR (pointer) Record
maps an IP address to a domain
192.168.0.100 > ws01.techprodevops.com

CNAME (canonical) Record
creates an alias for a domain
machine.techprodevops.com > ws01.techprodevops.com

MX (mail exchange)

# Active Directory

is a live directory or database that stores 
- user accounts
- passwords
- computers
- printers
- file shares
- security groups
- permissions

Security Groups may contain other objects and groups


purpose of AD 
- security authentication
    only allow authorized users to logon to network computers
- centralized security management of network resources
    user accounts are stored in one place instead of each computer

Most Common Tasks in AD
- reset passwords
- create/delete user accounts

Reach AD from Server Manager, Tools, Active Directory Users and Computers

Containers
object containers

Organizational Units
it can hold users, groups and computers of a specific unit in an organization or a company
OUs can have Group Policies

- Right click on your domain in Active Directory Users and Computers Window
- click New and then Organizational Unit
- name it as "techpro"
- Under OU techpro, create 2 OUs, administrators and users
- right click on admins and click new and then user
- set user name, logon name and password settings
- it is a good practice for security to not check the password check boxes on the next page.
- as the user was created double click on the user object name
- go to the Member Of tab
- click add and type in Domain Admins then click Check Names, if Domain Admins is underlined then click OK
- now your user is a member of Administrators
- ok now, try searching for your user name
- searching in the Entire Directory will be broadest search
- you can search not only by name but also e-mail and other details using Advanced search
- once you find the user, you can right click on its name and reset its password for example. you can disable account, delete etc.

- right click on the users OU and click new Group
- specify group name, group scope and group type
- group scope domain local is only valid within domain, global is reachable from other domains and universal is reachable from other forests
- group type security is for security group, distribution is for email groups.
- after clicking OK right click on group sales and then click properties
- on sales group properties window, members and member of tabs are important.
- on Members tab, if you click add an specify a user name it will be added to this group.
- on Member Of tab, if you click add and specify a group name, like Administrators, the user will be member of it.

* Using Queries to quick search
- right click on saved queries, click new  and query
- on the new query window type name, description, etc
- name: 30 Days Since Last Logon
- query root: leave default domain
- make sure include subcontainers is checked
- Click Define Query and select common queries
- select days since last logon and then click OK to close the dialog box.
- Click OK to close new query dialog box.
- When you need the query you simply right click on the query name and click Export List


What is Active Directory?
A database of users that operates on SQL
X A live directory or database taht handles security for user accounts, computers and more

Speaking of Active Directory, what does OU stand for?
Operational Unit
X Organizational Unit

When is Active Directory installed on a server?
X When an administrator installs the Active Directory Domain Services Server Role
When an administrator installs Group Policy Management


## Group Policy

Tool to easily configure users and computers in AD
- a Group Policy Object is applied on OUs to take effect
- the contents of OU like users and computers will be effected by GPO
- GPO is applied recursively, it effects the objects underneath
- Go to Server Manager and Tools and then Group Policy Management
- At he top most you will see forest
- Below the forest you will see those main titles:
-- domains
-- Sites
-- Group Policy Modeling
-- Group Policy Results

- under domains we will see our domain
- under our domain we will see the GPO named default domain policy which effects whole domain
- on OUs here, you can right click and link this to a GPO
- or you can create a new GPO right clicking on the domain or OUs
- after creating GPO, right click and click edit to configure
- Group Policy Management Editor opens
- There are 2 main divisions, Computer and User Configuration
- Computer Configuration is related with computers only, does not effect users,
- User Configuration is related with users only, does not effect computers
- Under User Configuration let's change some settings under Control Panel, Desktop and System
- we select enable to activate a setting

# Create User Accounts using PowerShell ISE

- create single user on powershell
- create multiple users using a CSV file


























