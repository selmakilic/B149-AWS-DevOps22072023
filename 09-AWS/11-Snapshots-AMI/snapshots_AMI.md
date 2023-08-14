# Hands-on AMI & Snapshots : Working with EC2 Snapshots

Purpose of the this hands-on training is to teach students how to take a snapshot of EC2 instance, create an image from EC2 instance and using Data Lifecycle Manager. 

## Learning Outcomes

At the end of the this hands-on training, students will be able to;

- take snapshots of EC2 instances on AWS console.

- create images from EC2 instances on AWS console.

- understand of difference between the image and the snapshot.

- create different types of AMI.

- using the Data Lifecycle Manager 

- copying and sharing AMI

## Outline

- Part 1 - Creating an Image from the Snapshot of the Nginx Server and Launching a new Instance

- Part 2 - Creating an Image and Launching an Instance from the same Image

- Part 3 - Creating an Image from the Snapshot of the Root Volume and Launching a new Instance

- Part 4 - Creating an Image from Customized Instance and Launching an instance from the same AMI

- Part 5 - Make AMI Public

- Part 6 - Using Data Lifecycle Manager 


## Part 1 - Creating an Image from the Snapshot of the Nginx Server and Launching a new Instance

#### 1. Launch an instance with following configurations.

  #### a. Security Group: Allow SSH and HTTP ports from anywhere with named "SSH and HTTP"

  #### b. User data (paste it for Nginx)

  #### c. Amazon Linux 2 AMI and t2.micro

  #### d. Key pair 

```bash
#! /bin/bash
yum update -y
amazon-linux-extras install nginx1.12
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

  #### e. Tag: Since "Data Lifecycle Manager" work based on tags, we use tag to customize Instance!!!!!!!! 

```text
  Key: Name 
  Value: SampleInstance  
```
#### 2. First copy the Instance ID and then go to EC2 dashboard and click "Snapshot" section from left-hand menu.


#### 3. Click `create snapshot` button.

Select resource type : Instance
Instance ID          : Select the instance ID of SampleInstance
Name(manually)       : Instance-Snapshot_First

#### 4. Click create snapshot.

#### 5. Click snapshot `Action` menu and select `create image`

```text
Name        : techproAMI_1
Description : techproAMI_1
```


#### 6. Click the `launch instance` tab.

#### 7. Click `My AMIs` from AMI tabs. Make sure `Owned by me` is selected.

#### 8. Select `techproAMI_1` as AMI

#### 9. Make sure that keypair and security group rules (SSH, HTTP) are properly selected.

#### 10. Launch instance named `Instance_1_from_Sample_Instance`

#### 11. Copy the public IP of the newly created instance and paste it to the browser.

#### 13. Check if Nginx Web Server is working.
------------------------------------------------------------------------------------------------------
## Part 2 - Creating an Image and Launching an Instance from the same Image with "Action Menu"

#### 14. Go to `SampleInstance`

#### 15. Click the actions menu.

#### 16. Select image >> create image.
```text
Name        : techproAMI_2
Description : techproAMI_2
```

#### 17. Click AMI section from left hand menu and show `techproAMI_2`

#### 18. After techproAMI creation process is completed, click snapshot section from left-hand menu.

#### 19. Show that AWS has created a new snapshot for newly created `techproAMI_2` image.

#### 20. Click the `launch instance` tab.

#### 21. Click `myAMI` from left-hand menu.

#### 22. Select `techproAMI_2`.

#### 23. Explain that and `user data` same as original EC2 Nginx instance.

#### 24. Launch instance as named "Instance_2_from_Sample_Instance_"

#### 25. Copy the public IP of the newly created instance and paste it to the browser.

#### 26. Show that the Nginx Web Server is working.

#### 26. Check the "Snapshot Menu" if there is an extra snapshot or not. If yes, then  name it. Explain the reason.

```text
Name : Snapshot_Second_Auto 
```

----------------------------------------------------------------------------------------------
## Part 3 - Creating an Image from Customized Instance and Launching an instance from the same AMI


#### 37. Connect to `SampleInstance` with SSH.

#### 38. Create a file named `i_am_here.txt`

```bash
touch i_am_here.txt
ls
```

#### 39. Exit from the instance.

#### 40. Go to EC2 console.

#### 41. Select the instance named `SampleInstance`.

#### 42. Click the actions menu.

#### 43. Select image >> create image.

```text
Name        : techproAMI_3
Description : techproAMI_3
```

#### 44. Click the `launch instance` tab.

#### 45. Click `myAMI` from left-hand menu

#### 46. Select `techproAMI_3`

#### 47. Launch instance as named "Instance_3_from_Sample_Instance_"

#### 48. Connect to `Instance_3_from_Sample_Instance` with SSH. Don't forget to connect with "ec2-user" if you copy from the connect tab you'll see "root@...."

#### 49. Show `i_am_here.txt` with `ls`.
```bash
ls
```
------------------------------------------------------------------------------------------------
## Part 4 - Make AMI public.

#### 45. First go to the AMI section  from left-hand menu and say students to **not to do** together.

#### 46. Select the techproAMI_4

#### 47. Click on permission and Click on  "Make public "

#### 48. After a while it will be public. Send the AMI ID from slack

#### 49. Tell the student to  go Launch Instance-----> Choose AMI------> Community AMI, and paste the "ID of AMI" to the search bar 
-------------------------------------------------------------------------------------------------
## Part 6 - Using Data Lifecycle Manager :


#### 50. In the Amazon EC2 Console, under `Elastic Block Store——>Lifecycle Manager——>Create Snapshot Lifecycle Policy`. 

#### 51. You can select the policy type depending on your target component to snapshot. 

```text
Policy type: EBS snapshot policy
```

#### 52. You can select the resource type as volume or instance depending on whether you want to schedule snapshots. We will be selecting "Instance" as the resource type.

Select resource type: Instance

#### 53. Enter a description:

```text
Description: "Test policy"
```
#### 54. Now select the tags associated with the EBS volumes or EC2 instance, it will depend on the option chosen above. We are  including all the instances with tag name : 


```text
  Key: Name 
  Value: SampleInstance  
```
#### 55.This policy must be associated with an IAM role that has the appropriate permissions. If you choose to create a new role, you must grant relevant role permissions and setup trust relationships correctly. If you are unsure of what role to use, choose Default role. 
```text
  Default Role 
```

#### 55. Schedules define how often the policy is triggered, and the specific actions that are to be performed. The policy must have at least one schedule. This schedule is mandatory, while schedules 2, 3, and 4 are optional.

```text
Policy Schedule 1
Schedule name : My_schedule
Frequency     : Daily
Every         : 24H
Starting at   : 03:00 UTC
Retention Type: Count 
Retain        : 5
```
#### 56. Copy the "Copy tags from source" option. Thanks to this option, tags from the source volume are automatically assigned to snapshots created by the schedule.

#### 57. Cross region copy

```text
Uncheck "Enable cross region copy"
```
#### 58. Cross-account sharing

```text
Check "Enable cross-account sharing"
```
#### 59. Cross-account sharing
Confirm the Policy Summary to be sure that the rules are specified correctly, as per your requirement. Choose Enable policy to start the policy, runs at the next scheduled  time.

```text
Enable Policy
```
#### 60. Finally, choose Create Policy. 

#### 61. That's it, you're DLM policy is created. Check it from console. 

#### 62. Delete the policy. 
