#
# MAINTAINER Prima Artyom "artyom.prima@yandex.kz"
#
terraform {
  required_version = "> 0.12.0"
}
provider "aws" {
    region               	= var.availability_zone
    access_key          	= var.aws_access_key
    secret_key          	= var.aws_secret_key
}

#---------------------------------------------------
# Create security group
#---------------------------------------------------
resource "aws_security_group" "sg" {
    name                 	= "${var.name}-sg-${var.environment}"
    description          	= "Security Group ${var.name}-sg-${var.environment}"
    vpc_id               	= var.vpc
    lifecycle {
        create_before_destroy   = true
    }
    # allow traffic for TCP 22 to host
    dynamic "ingress" {
      for_each = var.allowed_ports
      content {   
        from_port        	= ingress.value
        to_port          	= ingress.value
        protocol         	= "tcp"
        cidr_blocks      	= ["${var.my_ip_address}/32"]
      }
    }
    # allow traffic for TCP 22 from host
    egress {
        from_port        	= 0
        to_port          	= 0
        protocol         	= "-1"
        cidr_blocks      	= ["0.0.0.0/0"]
    }

    tags = {
        Data_Creation    	= var.data_creation
        Your_First_Name  	= var.your_first_name
        Your_Last_Name   	= var.your_last_name
        AWS_Account_ID   	= var.aws_account_id
    }
}

#---------------------------------------------------
# Define SSH key pair for our instances
#---------------------------------------------------
resource "aws_key_pair" "key_pair" {
  key_name                      = "${var.name}-key_pair-${var.environment}"
  public_key                    = "${file("~/.ssh/id_rsa.pub")}"
}

#---------------------------------------------------
# Create AWS Instance
#---------------------------------------------------
resource "aws_instance" "instance" {
    count                       = var.number_of_instances

    ami                         = var.ami_id
    instance_type               = var.ec2_instance_type
    user_data                   = <<EOF
#!/bin/bash

yum -y update

yum -y install httpd

echo '<table><tr><th>Key</th><th>Value</th></tr><tr><td>Data_Creation</td><td>"${var.data_creation}"</td></tr><tr><td>Your_First_Name</td><td>"${var.your_first_name}"</td></tr><tr><td>Your_Last_Name</td><td>"${var.your_last_name}"</td></tr><tr><td>AWS_Account_ID</td><td>"${var.aws_account_id}"</td></tr></table>'  > /var/www/html/index.html

sudo service httpd start

chckconfig httpd on
EOF


    key_name                    = aws_key_pair.key_pair.id
    vpc_security_group_ids      = [aws_security_group.sg.id]
    root_block_device {
        volume_size 		= var.disk_size
    }
    
    tags = {
        Data_Creation   	= var.data_creation
        Your_First_Name 	= var.your_first_name
        Your_Last_Name  	= var.your_last_name
        AWS_Account_ID  	= var.aws_account_id
    }
}
/*
#---------------------------------------------------
# Get tags
#---------------------------------------------------

resource "local_file" "terraform_final" {
 content = templatefile("final.tpl",
 { 
   Data_Creation   = aws_instance.instance[0].tags.Data_Creation 
   Your_First_Name = aws_instance.instance[0].tags.Your_First_Name
   Your_Last_Name  = aws_instance.instance[0].tags.Your_Last_Name
   AWS_Account_ID  = aws_instance.instance[0].tags.AWS_Account_ID
 }
 )
 filename = "bootstrap.sh"
}
*/


