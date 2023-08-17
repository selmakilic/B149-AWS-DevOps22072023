
# create key-pair 
aws ec2 create-key-pair --key-name practice-key --query 'KeyMaterial' --output text > practice-key

# run instances 
aws ec2 run-instances --image-id ami-053b0d53c279acc90 --instance-type t2.micro --key-name practice-key

# get public IP of the instance
aws ec2 describe-instances --filters "Name = key-name, Values = practice-key" --query "Reservations[].Instances[].PublicIpAddress[]"

# ssh to instance
ssh -i practice-key ubuntu@18.212.108.59 

# install aws cli on Ubuntu machine
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip
unzip awscliv2.zip
sudo ./aws/install

# use AWS CLI on Ubuntu machine to create a S3 bucket
```bash
aws s3 mb s3://mfatih-bucket
```

- make_bucket failed: s3://mfatih-bucket Unable to locate credentials
why did you get this error?
AWS CLI works with access keys, AWS CLI is installed but they are not configured here.
You can configure access keys by aws configure, or
you can use a Role.
Let's use a role

# Create a role for the Ubuntu instance
- go to IAM service and create a role for EC2 and select S3FullAccess permissions
- name the role an exit IAM

# assign the role to EC' ubuntu instance
- go to EC2 and select ubuntu machine.
- click actions, security then Modify IAM Role
- Select the role you created then click Update

# now use AWS CLI on Ubuntu machine
```bash
aws s3 mb s3://mfatih-bucket
```

# delete resources created using Ubuntu
```bash
aws s3 rb s3://mfatih-bucket
```

# exit from Ubuntu and terminate remote instance
```bash
aws ec2 terminate-instances --instance-ids i-92394293
```


