
# use cloudshell to crate resources usşng AWS CLI 
- open cloudshell environment on AWS Console
- start using AWS CLI immediately without installation or configuration

```bash
aws s3 ls
aws s3 mb s3://mfatih-bucket
aws s3 rb s3://mfatih-bucket
aws ec2 describe-instances
```

# practice Auto Scaling Group

## create Launch Template
- create a launch template
with Amazon Linux 2023
with your key-pair
with ssh port open
with user data:
```bash
#!/bin/bash
yum install stress -y
```

# create ASG
- create ASG using the Launch Template you created
- set min: 1 desired: 2 max: 4
- use Target Tracking Policy and set CPU average usage to 40


# use ssh to invoke stress tool

- open a terminal, find your key-pair

```bash
ssh -i mfatih-key.pem ec2-user@publicIP stress --cpu 8 --timeout 3600
```
- wait to see the CPU metrics rise on Monitoring tabs of instances
- watch te new instance added to lower the CPU average.

# clear out the resources
- delete ASG policy
- delete ASG
- delete Launch Template