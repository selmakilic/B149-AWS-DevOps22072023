terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.23.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # Change this to your desired region
}

resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  description = "Allow desired ports for our instances"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "control_node" {
  ami           = "ami-026ebd4cfe2c043b2"
  instance_type = "t2.medium"
  key_name      = "rahmatullah_key"
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tags = {
    Name = "ansible_control"
    stack = "ansible_project"
    
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("./rahmatullah_key.pem")
  }

  
  provisioner "file" {
    source      = "./rahmatullah_key.pem"
    destination = "/home/ec2-user/rahmatullah_key.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname Control-Node",
      "sudo yum install -y python3",
      "sudo yum install -y python3-pip",
      "pip3 install --user ansible",
      "pip3 install --user boto3",
      "chmod 400 rahmatullah_key.pem"
    ]
  }
}

resource "aws_instance" "ansible_instance" {
  count = 3
  ami           = "ami-026ebd4cfe2c043b2"
  instance_type = "t2.micro"
  key_name      = "rahmatullah_key"
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tags = {
    Name = count.index == 0 ? "ansible_postgresql" : count.index == 1 ? "ansible_nodejs" : "ansible_react"
    stack = "ansible_project"
    environment = "development"
  }
}

output "control_node_ip" {
  value = aws_instance.control_node.public_ip
}

output "ansible_instance_ip" {
  value = aws_instance.ansible_instance.*.public_ip
}
