
# AWS CLI
- https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html

## What-Why-How

- AWS CLI is programmatic access to AWS resorces

- Using AWS CLI we will do automation scripting

- Open source tool to reach and manipulate AWS resources from command line of your operating system.

- Currently there are 2 versions. We will use version 2.

## Install AWS CLI (MS-Lınux-MacOS)

- https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html
 
  https://graspingtech.com/install-and-configure-aws-cli/

  ```bash
  aws --version
  ```  
    
### For MS Windows
  https://awscli.amazonaws.com/AWSCLIV2.msi

- You should also install CLI if you are using a virtual machine like WSL in your Windows system.

### For Linux (On Ubuntu)

```bash
sudo apt-get update
sudo apt-get upgrade
aws --version
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip
unzip awscliv2.zip
sudo ./aws/install

aws s3 ls
```

- So you have to configure according to your credentials.


## Configure AWS CLI

- AWS requires that all incoming requests are cryptographically signed. The AWS CLI does this for you. The "signature" includes a date/time stamp. Therefore, you must ensure that your computer's date and time are set correctly. If you don't, and the date/time in the signature is too far off of the date/time recognized by the AWS service, AWS rejects the request.

- After installation and configuration regardless of your operating system AWS CLI works with same commands.

### Connection to IAM
When you created an IAM user you check the programatic access.
Connect to console open your security credendials from the drop down menu by clicking your name or from IAM service.
You can have max 2 Access Keys correspond to access IDs. Once created, download csv file do not lose.

- **`AWS hesabinizdaki Access Key ID ve Secret Access Key`**

```bash
 aws configure

  AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
  AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
  Default region name [None]: us-west-2
  Default output format [None]: json
```

- For Windows
```cmd
  C:\Users\<username>\.aws
```
- For Linux

```bash
  /.aws

cat config
vi config
```

- Bakalim credentials'ta bir problem var mi:

```bash
aws s3 ls
```

```bash
# Yeni bir kullanici daha olusturayim
aws configure --profile <new-user>

# Bakalim bakalim kullanici olusmus mu
echo credentials
echo config
aws s3 ls --profile new-user
```

- Simdi hangi kullanici hakim kullanici olsun, yani AWS CLI yi kullanabilsin onu belirlemek icin;

- for linux and macOS
```bash
export AWS_PROFILE=new-user
```

- for Windows
```cmd
setx AWS_PROFILE <new-user>
aws sts get-caller-identity
```


## Basic Examples

- Structure of AWS CLI commands
  
```bash
# aws
aws help
  
# aws command subcommand help
aws s3 cp help
```

-  https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-services.html

-  https://docs.aws.amazon.com/cli/latest/index.html

### Examples

```bash
# Elimizdeki Instance(lar)in Bilgilerini dondurelim
aws ec2 describe-instances

# Elimizde birden fazla makine olabilir; sadece belirli ozellikleri saglayanlari dondurelim
https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html
# Dry run, o islemi yapmaya yetkimiz var mi yok mu onu dondurur.

aws ec2 describe-instances --filters "Name=instance-type,Values=t2.micro" # Makinalarin instance turlerini dondur

#   Query Kismi
aws ec2 describe-instances --filters "Name=instance-type,Values=t2.micro" --query "Reservations[].Instances[].InstanceId" # Makinelerin Instance ID lerini dondur

# Public IP lerini Query'le
aws ec2 describe-instances --filters "Name=instance-type,Values=t2.micro" --query "Reservations[*].Instances[*].PublicIpAddress"

# CLI ile EC2 Instance Ayaga Kaldiralim
aws ec2 run-instances --image-id ami-090fa75af13c156b4 --count 1 --instance-type t2.micro --key-name deneme
# count 1 yani 1 tane makina ayaga kaldir

#   CLI dan Makine Terminate Etme
aws ec2 terminate-instances --instance-ids <instanceID>
```

- Config Profile could not be found hatasi alinirsa: https://bobbyhadz.com/blog/aws-cli-config-profile-could-not-be-found#:~:text=The%20%22config%20profile%20could%20not,in%20your%20AWS%20credentials%20file.&text=When%20set%2C%20the%20AWS_PROFILE%20environment,using%20the%20default%20AWS%20profile.


```bash
# Kullanici olusturmak icin
aws iam create-user --user-name test
aws iam list-users

# Olusturdugun kullaniciyi silmek icin
aws iam delete-user --user-name test
aws iam list-users # Bakalim silmis mi

aws s3 ls # s3 bucket'lerini listeler
aws s3 ls s3://<bucket name> # Spesifik bir bucket'i ogrenmek istersen

# yerel bir dosyayı s3 bucket içine kopyalamak
aws s3 cp filename s3://<bucket name>/filename

# bucket içindeki dosyayı silmek
aws s3 rm s3://<bucket name>/filename

# bucket silmek
aws s3 rb s3://<bucket name> --force

```

- When it is done, stop and/or terminate the newly created instance either by using CLI or Console. 


===================
# Reference

## AWS CLI Configuration
​
```bash
aws configure
​
cat .aws/config
cat .aws/credentials
​
aws configure --profile techproed
​
aws s3 ls --profile techproed
​
export AWS_PROFILE=techproed
export AWS_PROFILE=default
​
aws configure list-profiles
​
aws sts get-caller-identity
```
​
## Commands About Key-pair
​
```bash
aws ec2 create-key-pair --key-name <key_name> --query 'KeyMaterial' --output text > <key_name>.pem
​
aws ec2 describe-key-pairs
​
aws ec2 delete-key-pair --key-name <key-name>
```
​
## Commands about IAM
​
```bash
aws iam list-users
​
aws iam create-user --user-name aws-cli-user
​
aws iam delete-user --user-name aws-cli-user
```
​
## Commands about S3
​
```bash
aws s3 ls
​
aws s3 mb s3://techproed
​
aws s3 cp in-class.yaml s3://techproed
​
aws s3 ls s3://techproed
​
aws s3 rm s3://techproed/in-class.yaml
​
aws s3 rb s3://techproed
```
​
## Commands about EC2
​
```bash
aws ec2 describe-instances
​
aws ec2 run-instances \
   --image-id ami-033b95fb8079dc481 \
   --count 1 \
   --instance-type t2.micro \
   --key-name KEY_NAME_HERE # put your key name
​
aws ec2 create-tags \
   --resources <INSTANCE_ID_HERE>
   --tags Key=Name, Value="created_from_aws_cli"
​
aws ec2 describe-instances \
   --filters "Name = key-name, Values = KEY_NAME_HERE" # put your key name
​
aws ec2 describe-instances --query "Reservations[].Instances[].PublicIpAddress[]"
​
aws ec2 describe-instances \
   --filters "Name = key-name, Values = KEY_NAME_HERE" --query "Reservations[].Instances[].PublicIpAddress[]" # put your key name
​
aws ec2 describe-instances \
   --filters "Name = tag-value, Values = TAG_NAME_HERE " --query "Reservations[].Instances[].PublicIpAddress[]" 
​
aws ec2 describe-instances \
   --filters "Name = instance-type, Values = t2.micro" --query "Reservations[].Instances[].InstanceId[]"
​
aws ec2 stop-instances --instance-ids INSTANCE_ID_HERE # put your instance id
​
aws ec2 terminate-instances --instance-ids INSTANCE_ID_HERE # put your instance id
​
# Working with the latest Amazon Linux AMI
​
aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --region us-east-1
​
aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --query 'Parameters[0].[Value]' --output text
​
aws ec2 run-instances \
   --image-id $(aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --query 
'Parameters[0].[Value]' --output text) \
   --count 1 \
   --instance-type t2.micro
```

## Upgrade from AWS CLI Version 1 to Version 2

### Update AWS CLI Version 1 on Amazon Linux (comes default) to Version 2
​
### Remove AWS CLI Version 1

```bash
sudo yum remove awscli -y # pip uninstall awscli/pip3 uninstall awscli might also work depending on the image
```

### Install AWS CLI Version 2

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip  #install "unzip" if not installed
sudo ./aws/install
​```

### Update the path accordingly if needed

```bash
export PATH=$PATH:/usr/local/bin/aws
```
