provider "aws" {
	region = "eu-west-1"
}

resource "aws_instance" "webserver" {
	ami = "ami-0ea3405d2d2522162"
	instance_type = "t2.micro"
	vpc_security_group_ids = [aws_security_group.webserver.id]
	user_data = templatefile ("user_data.sh.tpl", {
		first_name = "Test_Name"
		last_name  = "Jun"
		names = ["1213","qwere"]
	})
}

resource "aws_security_group" "webserver" {
	name = "Webserver sec group"
	description = "Test group"

	ingress {
	from_port = 80
	to_port   = 80
	protocol  = "tcp"
	cidr_blocks =["0.0.0.0/0"]
 	}
	
	ingress {
	from_port = 443
	to_port   = 443
	protocol  = "tcp"
	cidr_blocks =["0.0.0.0/0"]
 	}

 	egress {
	from_port = 0
	to_port   = 0
	protocol  = "-1"
	cidr_blocks =["0.0.0.0/0"]
 	}


}