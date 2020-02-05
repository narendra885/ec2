variable "sg" {}
variable "sub" {}
#variable "bucket" {
  
#}
variable "vpc" {}
variable "instances" {}





resource "aws_security_group" "elb-sg" {

  vpc_id      = "${var.vpc}"

  #Allow HTTP from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_elb" "web" {
  
  subnets         = "${var.sub}"
  security_groups = ["${aws_security_group.elb-sg.id}"]
  instances       = ["${var.instances}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  

}


output "lbid" {
  value = "${aws_elb.web}"
}
