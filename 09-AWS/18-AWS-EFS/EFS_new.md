# Hands-on EFS-01 : How to Create EFS & Attach the EFS to the multiple EC2 Linux 2 Instances

## Outline

- Part 1 - Prep(EC2 SecGrp, EFS SecGrp, EC2 Linux 2 Instance)

- Part 2 - Creating EFS

- Part 3 - Attach the EFS to the multiple EC2 Linux 2 instances

- Part 4 - Auto-mount EFS on Reboot 


## Part 1 - Prep (EC2 SecGrp, EFS SecGrp, EC2 Linux 2 Instance)

### Step 1 - Create EC2 SecGrp:

- Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.

- Choose the Security Groups on left-hand menu

- Click the `Create Security Group`.

```text
Security Group Name  : EC2 SecGrp
Description          : EC2 SecGrp
VPC                  : Default VPC
Inbound Rules:
    - Type: SSH ----> Source: Anywhere
Outbound Rules: Keep it as default
Tag:
    - Key   : Name
      Value : EC2 SecGrp
```

### Step 2 - Create EFS SecGrp:

- Click the `Create Security Group`.

```text
Security Group Name  : EFS SecGrp
Description          : EFS SecGrp
VPC                  : Default VPC
***Inbound Rules:
    - Type: NFS ----> Port: 2049 ------>Source: sg-EC2 SecGrp
Outbound Rules: Keep it as default
Tag:
    - Key   : Name
      Value : EFS SecGrp
```

### Step 3 - Create EC2 :

- Configure First Instance in N.Virginia

```text
AMI             : Amazon Linux 2
Instance Type   : t2.micro
Network         : default
Subnet          : 1b
Security Group  : EC2 SecGrp
    Sec.Group Name : EC2 SecGrp
Tag             :
    Key         : Name
    Value       : EC2-1
```

- Configure Second Instance in N.Virginia

```text
AMI             : Amazon Linux 2
Instance Type   : t2.micro
Network         : default
Subnet          : 1a
Security Group  : EC2 SecGrp
    Sec.Group Name : EC2 SecGrp
Tag             :
    Key         : Name
    Value       : EC2-2
```

## Part 2 - Creating EFS

Open the Amazon EFS console at https://console.aws.amazon.com/efs/.

- Click "Create File System" 

```text

Name                            : FirstEFS
Virtual Private Cloud (VPC)     : Default VPC (Keep default)
Availability and Durability     : Regional (Keep default)
```

- To customize settings manually, select the  'Customize' option seen at the bottom 

```text

General

Name                    : FirstEFS (Comes default from previous setting)
Storage class: Standard

Availability and Durability : Regional (Comes default from previous setting) 

Automatic backups       : Unchecked "Enable automatic backups"  

Lifecycle management    : Select "None"
Encryption              : Enable encryption of data at rest 
Performance settings
Throughput mode :   Bursting   

Additional settings:
Performance mode        : General Purpose  

Tags                    : optional
```
Click Next

```text

- Virtual Private Cloud (VPC): Default VPC

- Mount targets: 
  - select all AZ (keep it default)
  - Clear "default sg" from all AZ
  - Security groups >>> Add "EFS SecGrp" to all 
  

- Show that you can only add one mount point for each AZ though it has multiple subnets(for example custom VPC) 
```
Click next 

```text
File system policy - optional------> keep it as is   
```
Click next. Then review and  

Show that it is created. 

## Part 3 - Attach the EFS to the multiple EC2 Linux 2 instances

### STEP-1: Configure the EC2-1 instance


- open EC2 console

-  Connect to EC2-1 with SSH.
```text
ssh -i .....pem ec2-user@..................
```
- Update the installed packages and package cache on your instance.

```bash
sudo yum update -y
```
- Change the hostname 

```bash
sudo hostnamectl set-hostname First
```

- type "bash" to see new hostname.

```bash
bash
```

- Install the "Amazon-efs-utils Package" on Amazon Linux

```bash
sudo yum install -y amazon-efs-utils
```

- Create Mounting point 

```bash
sudo mkdir efs   
```

- Go to the EFS console and click  on "FirstEFS" . Then click "Attach" button seen top of the "EFS" page.
"FirstEFS" >> "Attach" >>> Mount via DNS >>> Using the EFS mount helper >>copy
- On the pop up window, copy the script seen under "Using the EFS mount helper" option: "sudo mount -t efs -o tls fs-60d485e2:/ efs"

- Turn back to the terminal and mount EFS using the "EFS mount helper" to the "efs" mounting point

```bash
sudo mount -t efs -o tls fs-xxxxxx:/ efs
```
- Check the "efs" folder
```bash
ls
```
- Go the "efs" folder and create a new file with vim editor.

```bash
cd efs
sudo vim example.txt
```
- Write something, save and exit;
```bash
"hello from first EC2-1"
esc:wq
```


- check the example.txt

```bash
cat example.txt
```

- Check the IP of EFS mount point 

```bash
   
```

### STEP-2: Configure the EC2-2 instance


-  Connect to EC2-2 with SSH.
```text
ssh -i .....pem ec2-user@..................
```
- Update the installed packages and package cache on your instance.

```bash
sudo yum update -y
```
- Change the hostname 

```bash
sudo hostnamectl set-hostname Second
```
- type "bash" to see new hostname.

```bash
bash
```
- Install the "Amazon-efs-utils Package" on Amazon Linux

```bash
sudo yum install -y amazon-efs-utils
```

- Create Mounting point 

```bash
sudo mkdir efs
ls
```

- Go to the EFS console and click  on "FirstEFS" . Then click "Attach" button seen top of the "EFS" page.

- On the pop up window, copy the script seen under "Using the EFS mount helper" option: "sudo mount -t efs -o tls fs-60d485e2:/ efs"

- Turn back to the terminal and mount EFS using the "EFS mount helper" to the "efs" mounting point

```bash
sudo mount -t efs -o tls fs-xxxxxxx:/ efs
```
- Check the "efs" folder
```bash
ls
cd efs
```
- Check the example.txt. Show that you can also reach the same file.

```bash
cat example.txt
```

- Add something example.txt

```bash
sudo vim example.txt
"hello from first EC2-2"
esc:wq
```
- Check the example.txt

```bash
cat example.txt

"hello from first EC2-1"
"hello from first EC2-2"
```
- Connect from EC2-1 to the "efs" and show the example.txt:


```bash



```
### STEP-3: Configure the EC2-3 instance with EFS while Launching
ıns kalk maun ols

- go to the EC2 console and click "Launch Instance"
sam ınst3
- Configure third Instance in N.Virginia

```text
AMI             : Amazon Linux 2
Instance Type   : t2.micro
Network         : ***Edit  Choose one of the default subnet 
Security Group  : EC2 SecGrp
    Sec.Group Name : EC2 SecGrp
Configure Storage : ***Advanced

                 File systems   Edit Add file system-------> FirstEFS 
                *** (Note down the mnt point "/mnt/efs/fs1")
                Advanced details:
                                User data   ktr et
Tag             :
    Key         : Name
    Value       : EC2-3
```
- Connect to EC2-3 with SSH

- Change the hostname 

```bash
sudo hostnamectl set-hostname Third
bash
```

```text
ssh -i .....pem ec2-user@..................
```
- Go to the directory of mount target 
```bash
cd /mnt/efs/fs1/
```
- Show the example.txt:

```bash
cat example.txt

"hello from first EC2-1"
"hello from first EC2-2"
```
 - Add something example.txt

```bash
sudo vim example.txt
"hello from first EC2-3"
esc:wq
```
- Check the example.txt

```bash
cat example.txt

"hello from first EC2-1"
"hello from first EC2-2"
"hello from first EC2-3"
```

# PART 4 - AUTOMOUNT EFS ON REBOOT

- Switch to EC2-1 or EC2-2

- reboot and show that configuration is gone for EC2-1 / EC2-2. Since EC2-3 is configured by AWS fstab is set. 
```bash
sudo reboot now   
cd efs
```
- back up the /etc/fstab file.
```bash
sudo cp /etc/fstab /etc/fstab.bak         
```
- open /etc/fstab file and 

```bash
sudo vim /etc/fstab 
```
- add the following info to the existing one.
```bash
 fs-0c1fcea5b09f0383d:/  /home/ec2-user/efs  efs  defaults,_netdev   0    0        

```
-esc:wq   to save

- reboot and show that configuration exists (NOTE)
```bash
sudo reboot now   
ls
cd efs
cat example.txt

```
- if there is data on it, check if the data still persists.

- Terminate instances and delete file system from console.
