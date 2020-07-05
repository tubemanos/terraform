provider "aws"{
 profile = "test-cluster"
 region  = "eu-west-1"
}

resource "aws_vpc" "cluster_vpc"{
 cidr_block = "10.0.0.0/16"
 tags = {
  Name = "Cluster VPC"
 }
}

resource "aws_security_group" "SSH_sg"{
 name = "SSH_sg"
 description = "ssh_backdoor_way"
 ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
}


resource "aws_security_group" "HTTP_sg"{
 name = "HTTP_sg"
 description = "HTTP_sec_gr"
 
ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }

egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 }

}


resource "aws_subnet" "Cluster_public_subnet"{
 vpc_id = aws_vpc.cluster_vpc.id
 cidr_block = "10.0.30.0/24"
 map_public_ip_on_launch = true
 availability_zone_id = "euw1-az1"
 tags = {
  Name = "Cluster public subnet"
 }
}

resource "aws_subnet" "Cluster_DB_subnet"{
 vpc_id =  aws_vpc.cluster_vpc.id
 cidr_block = "10.0.40.0/24"
 map_public_ip_on_launch = true
 availability_zone_id = "euw1-az1"
 tags = {
  Name = "Cluster DB public subnet"
 }
}

resource "aws_internet_gateway" "Cluster-IGW"{
  vpc_id =  aws_vpc.cluster_vpc.id
  tags = {
  Name = "Cluster IGW"
 }
}

resource "aws_eip" "cluster_eip"{
 vpc = true
 tags = {
  Name = "Cluster EIP"  
 }
}

resource "aws_instance""PHP"{
 ami = "ami-0ea3405d2d2522162"
 count = 1
 instance_type = "t2.micro"
 vpc_security_group_ids = [aws_security_group.HTTP_sg.id,aws_security_group.SSH_sg.id]
 tags = {
  Name = "PHP server"
  Owner = "Hillel Z-command"
  Project =  "Express proj"
 }
}

resource "aws_instance""USRV"{
 ami = "ami-0ea3405d2d2522162"
 count = 1
 instance_type = "t2.micro"
 vpc_security_group_ids = [aws_security_group.HTTP_sg.id,aws_security_group.SSH_sg.id]
 tags = {
  Name = "USRV server"
  Owner = "Hillel Z-command"
  Project =  "Express proj"
 }
}

resource "aws_instance""DB"{
 ami = "ami-0ea3405d2d2522162"
 count = 1
 instance_type = "t2.micro"
 vpc_security_group_ids = [aws_security_group.HTTP_sg.id,aws_security_group.SSH_sg.id]
 tags = {
  Name = "DB Server"
  Owner = "Hillel Z-command"
  Project =  "Express proj"
 }
}

