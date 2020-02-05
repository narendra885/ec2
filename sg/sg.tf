variable "name" {}
variable "cidrvpc" {}
variable "portnumber" {}
variable "protocol" {}
variable "cidrsubnet" {}
variable "cidrsubnet2" {}

#variable "insid" {}



#############################################VPC#############################

resource "aws_vpc" "main" {
     #name = "${var.name}"
     
     cidr_block  = "${var.cidrvpc}"
     instance_tenancy = "default"
     enable_dns_hostnames = true
     enable_dns_support   = true

    
    tags = {
    Name = "${var.name}"
  }
}
########################################Subnets#######################################
resource "aws_subnet" "sub" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.cidrsubnet}"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.name}"
  }
}
  resource "aws_subnet" "sub2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.cidrsubnet2}"
  availability_zone = "us-east-2c"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.name}"
  }
  }

################################################gateway########################################
resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.main.id}"

}
#########################Routetable#####################################################
resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.main.id}"
  tags = {
    Name = "${var.name}"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ig.id}"
    
  }


}

 resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.sub.id}"
  route_table_id = "${aws_route_table.r.id}"
}
resource "aws_route_table_association" "b" {
  subnet_id      = "${aws_subnet.sub2.id}"
  route_table_id = "${aws_route_table.r.id}"
}


#resource "aws_network_interface" "main" {
#  subnet_id   = "${aws_subnet.main.id}"
#  private_ips = [""]
#}

########################################Security Group######################################
resource "aws_security_group" "sg" {
    name = "sg"
    vpc_id  = "${aws_vpc.main.id}"  
    tags = {
    Name = "${var.name}"
  }
    ingress {
        from_port = "22"
        to_port  = "22"
        protocol = "${var.protocol}"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = "${var.portnumber}"
        to_port  = "${var.portnumber}"
        protocol = "${var.protocol}"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = "0"
        to_port =  "65535"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
 
    }

}
 

######################################out put#############################################
output "sg_out_id" {
  value = "${aws_security_group.sg.id}"
}
output "sub_id" {
  value = "${aws_subnet.sub.id}"
}

output "sub_id2" {
  value = "${aws_subnet.sub2.id}"
}
output "vpc_id" {
  value = "${aws_vpc.main.id}"
}
#output "interface_id" {
#  value = "${aws_network_interface.main.id}"
#}
