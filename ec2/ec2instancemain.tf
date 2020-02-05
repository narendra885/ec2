
variable "amiid" {}
variable "instancetype" {}
variable "name" {}
variable "keyname" {}
variable "sg_id" {}
variable "sub2id" {}

variable "subid" {}
#variable "niid" {}
variable "private_key" {}
#variable "sourcepath" {}




##############################Instance######################################################
resource "aws_instance" "main" {
  ami           = "${var.amiid}"
  instance_type = "${var.instancetype}"
  key_name = "${var.keyname}"
  vpc_security_group_ids = ["${var.sg_id}"]
  subnet_id = "${var.subid}"
  tags = {
    Name = "${var.name}"
  }
  provisioner "file" {
    source      = "E:/terraform scripts/my scripts/moudles/ec2/test.sh"
    destination = "/home/ubuntu/test.sh"
    connection {
       type     = "ssh"
       user = "ubuntu"
       private_key = "${var.private_key}"
       host = "${self.public_ip}"

       agent = "false"
     }  
  }
 # associate_public_ip_address = "true"
  #network_interface {
 #   network_interface_id = "${var.niid}"
 #   device_index         = 0
 # }

 

   
     
  provisioner "remote-exec" {
    inline = [
      "cd /home/ubuntu",
      "sudo chmod 777 test.sh",
      "sudo sh test.sh"
    ]
     connection {
       type     = "ssh"
       user = "ubuntu"
       private_key = "${var.private_key}"
       host = "${self.public_ip}"
       agent = "false"
     }  
  
  
  
 

  }

}


#####################################second###############################################
resource "aws_instance" "secondmain" {
  ami           = "${var.amiid}"
  instance_type = "${var.instancetype}"
  key_name = "${var.keyname}"
  vpc_security_group_ids = ["${var.sg_id}"]
  subnet_id = "${var.sub2id}"
  tags = {
    Name = "${var.name}"
  }
  provisioner "file" {
    source      = "E:/terraform scripts/my scripts/moudles/ec2/test.sh"
    destination = "/home/ubuntu/test.sh"
    connection {
       type     = "ssh"
       user = "ubuntu"
       private_key = "${var.private_key}"
       host = "${self.public_ip}"

       agent = "false"
   
    }
  }     
      provisioner "remote-exec" {
         inline = [
         "cd /home/ubuntu",
         "sudo chmod 777 test.sh",
          "sudo sh test.sh"
            ]
       connection {
       type     = "ssh"
       user = "ubuntu"
       private_key = "${var.private_key}"
       host = "${self.public_ip}"
       agent = "false"
      }      
  
  
      }

  
 # associate_public_ip_address = "true"
  #network_interface {
 #   network_interface_id = "${var.niid}"
 #   device_index         = 0
 # }

 

   
     
  provisioner "remote-exec" {
    inline = [
      "cd /home/ubuntu",
      "sudo chmod 777 test.sh",
      "sudo sh test.sh"
    ]
     connection {
       type     = "ssh"
       user = "ubuntu"
       private_key = "${var.private_key}"
       host = "${self.public_ip}"
       agent = "false"
     }  
  
  
  
 

  }

}

#################################output#######################################################

output "instanceid" {
  value = "${aws_instance.main.id}"
}
output "instance_ips" {
  value = "${aws_instance.main.*.public_ip}"
}

output "instance_ips2" {
  value = "${aws_instance.secondmain.*.public_ip}"
}