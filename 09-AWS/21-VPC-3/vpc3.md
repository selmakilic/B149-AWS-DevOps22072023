# Hands-on VPC-03 : VPC peering 

# Part 1 - Creating VPC peering between two VPCs (Default and Custom one)

### STEP 1 : Prep---> Launching Instances


- We will launch two Instances. First instance will be in "az1a-private-subnet" of "myVPC",and the other one will be in your "Default VPC". 

- In addition, since the private EC2 needs internet connectivity to set user data, we also need NAT Gateway or NAT Instance.

A. Configure Public Windows instance in **Default VPC.

```text
AMI             :  Windows Server 2022 Base
Instance Type   : t2.micro
Network         : Default VPC
Subnet          : Default Public Subnet
Security Group  : 
    Sec.Group Name : WindowsSecGr
    Rules          : RDP --- > 3389 ---> Anywhere
Tag             :
    Key         : Name
    Value       : Windows public

PS: For MAC, "Microsoft Remote Desktop" program should be installed on the computer.
```

- Windows makine'ye konsoldan `Connect > RDP Client` de.
- `Download Remote Desktop File` Windows bilgisayarlarinda uzak masaustu baglantisi olmayanlar icin; Uzak masaustu baglantisi default geliyor 
- `Remote Desktop Connection(Uzak Masaustu Baglantisi)`na tikla ve `Public DNS`, `User name` ve `Password`(Get Password ile olustur-Burada `deneme.pem` i bulmamiz lazim lokalimizden-) u ilgili yerlere yapistirip makineye baglan.

## C. Since the private EC2 needs internet connectivity to set user data, we use NAT Gateway

- Click Create Nat Gateway button in left hand pane on VPC menu
   myvpc
- click Create NAT Gateway.

```txt
Name                      : my-nat-gateway

Subnet                    :myvpc public-subnet-1a

Elastic IP allocation ID  : Allocate Elastic IP
```
- click "Create Nat Gateway" button

## D. Modify Route Table of Private Instance's Subnet

- Go to VPC console on left hand menu and select Route Table tab
myvpc
- Select "private-rt" ---> Routes ----> Edit Rule ---> Add Route
```
Destination     : 0.0.0.0/0
Target ----> Nat Gateway ----> my-nat-gateway
```
- click save routes

WARNING!!! ---> Be sure that NAT Gateway is in active status. Since the private EC2 needs internet connectivity to set user data, NAT Gateway must be ready.

## E. Configure Private instance in 'az1a-private-subnet' of 'myVPC'.

```text
name            : private-web -server
AMI             : Amazon Linux 2
Instance Type   : t2.micro
Key pair name   : xxx
Network         : myVPC 
Subnet          : az1a-private-subnet
 



Security Group    : 
SSH - 22 - Anywhere
All ICMP IPv4 - 0-65535 - Anywhere
HTTP - 80 - Anywhere
    
Tag             :
    Key         : Name
    Value       : Private WEB EC2
user data       :



#!/bin/bash
yum update -y
amazon-linux-extras install nginx1.12 -y
yum install git -y
systemctl start nginx
cd /usr/share/nginx/html
git clone https://github.com/techproedu/designer.git
chmod -R 777 /usr/share/nginx/html
rm index.html
cp -R ./designer/. .
systemctl restart nginx
systemctl enable nginx


```

- Open the internet explorer of windows machine and paste the private IP of EC2.

- It is not able to connect to the website 

- Website is in myVPC's private instance on private subnet

- Windows machine is in defaultVPC

# Part 2: Setting up Peering


- Go to 'Peering connections' menu on the left hand side pane of VPC

- Push "Create Peering Connection" button

```text
Peering connection name tag : First Peering
VPC(Requester)              : Default VPC
Account                     : My Account
Region                      : This Region (us-east-1)
VPC (Accepter)              : myVPC
```

- Hit `Create peering connection` button

- Select `First Peering' ----> Action ---> Accept Request ----> Accept Request`  # onlyms

- Now enter rules for route tables
2 Route Tables işlms
MyVPC VPC ----> Route Tables
- Go to `VPC > MyVPC VPC > Route Tables >  privat-rt Routes > Routes > Edit Routes > Add Route`

```bash
Destination: 172.31.0.0/16 # Bu default VPC ni CIDR blok u
Target ---> Peering connection ---> First Peering(pcx-...) ---> Save Changes
```
DEFAULT VPC ----> Route

- Go to **`Route Tables`** and select DEFAULT VPC Route Table ----> Routes ----> Edit routes`

```bash
Destination: 172.16.0.0/16 # Bu da MyVPC nin CIDR Block u
Target ---> peering connection ---> First Peering(pcx-...) ---> Save Changes
```

- Go to Windows instance named 'Windows public', write private-web -server IP address on browser and show them to website.


WARNING!!! ---> Please do not terminate "NAT Gateway" and "Private WEB EC2" for next part.


# Part 3 - Create VPC Endpoint


### A. Create S3 Bucket 

- Go to the S3 service on AWS console
- Create a bucket of `myvpc-kendiadin` with following properties, 

```bash
# Geri kalan hersey default
Versioning                  : Disabled
Server access logging       : Disabled
Tagging                     : 0 Tags
Object-level logging        : Disabled
Default encryption          : Default
CloudWatch request metrics  : Disabled
Object lock                 : Disabled
Block all public access     : unchecked
```


### B. Create IAM role to reach S3 from "Private WEB EC2"

- Go to IAM Service from AWS console and select roles on left hand pane

- click create role
```
Role ---> create role ---> AWS service ---> Use case EC2 ---> Next ---> Policy ---> "AmazonS3FullAccess" ---> Next 

Role Name : myS3FullAccessforEndpoint
Role description: my S3 Full Access for Endpoint
click create button
```
Go to EC2 service from AWS console

Select `Private WEB EC2" ---> Actions ---> Security ---> Modify IAM Role  select newly created IAM role named 'myS3FullAccessforEndpoint' ---> Apply`

### C. Configure Public Instance (Bastion Host)

```text
AMI             : Amazon Linux 2
Instance Type   : t2.micro
Key pair name   : XXX
Network         : myVPC
Subnet          : az1a-public-subnet
Security Group  : 
    Sec.Group Name : Public Sec.group(Bastion Host)
    Rules          : TCP --- > 22 ---> Anywhere
                     All ICMP IPv4  ---> Anywhere
                     HTTP--------> Anywhere
Tag             :
    Key         : Name
    Value       : Public EC2 (Bastion Host)
```



# Part 4: Connect S3 Bucket from Private WEB Instance

#### A. Connect to the Bastion host

- Go to terminal and connect to the Bastion host named 'Public EC2 (Bastion Host)'

- Using Bastion host connect to the EC2 instance in "private subnet" named 'Private WEB EC2 ' (using ssh agent or copying directly pem key into the EC2)

- Enable ssh-agent (start the ssh-agent in the background)

- Lokal >>>> GIt Bash >>> pem dosyanin oldugu konuma git.
```bash
eval "$(ssh-agent)"
```
```bash
ssh-add ./[your pem file name]
```
- connect to the ec2-in-az1a-public-sn instance in public subnet
```bash
ssh -A ec2-user@<publicinstanceinpublicipsi>
```
#### B.Connect to the Private Instance

-  logged into the bastion host connect to 
the private instance in the private subnet:
```bash
ssh ec2-user@[Your private EC2 private IP]
```
#### C. Use CLI to verify connectivity

- list the bucket in S3 and content of S3 bucket named "aws s3 ls "myvpc-endpoint" via following command

```
aws s3 ls
```
- go to private route table named "private-rt" on VPC service

- select ` NAT Gateway  delete"`

- Go to the terminal and try to connect again S3 bucket via following command

```bash
aws s3 ls
# nat gateway delete
# Elastic IP delete
```
- show that you are "not able to connect" to the s3 buckets list


### STEP 3: Create Endpoint

#### A. Connect to S3 via Endpoint

- Filt `myVPC` yi sec ve sol taraftan `Endpoints` 
- click `Create Endpoint`
```text
Name: myvpc-s3-endpoint
Service Category : AWS services
Service Name     : com.amazonaws.us-east-1.s3(Gateway)
VPC              : myVPC
Route Table      : myVPC-Private-RT
```
- Create Endpoint

- Go to private route table named 'private-rt' and show the endpoint rule that is automatically created by AWS (`pl-63a5400a` olan)

#### B. Connect  to S3 via Endpoint

- Go to terminal, list the buckets in S3 and content of S3 bucket named "aws s3 ls 
"myvpc-endpoint" via following command
```bash
aws s3 ls
aws s3 ls myvpc-endpoint
```
# Delete
instance
Peering
NAT gateways
Elastic IPs
Endpoint
s3 bucket
IAM rol













