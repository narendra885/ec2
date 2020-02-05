provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-2"
}


module "network" {
   name = "${var.name}"
  cidrvpc = "${var.cidrvpc}"
  cidrsubnet2 = "${var.cidrsubnet2}"
  cidrsubnet = "${var.cidrsubnet}"
  portnumber = "${var.portnumbers}"
  protocol ="${var.protocol}"
  #insid = "${module.instance.instanceid}"
  source = "./sg"
  
}



module "instance" {
amiid = "${var.amiid}"
 sg_id = "${module.network.sg_out_id}"
 instancetype = "${var.instancetype}"
 keyname = "${var.keyname}"
 name = "${var.name}"
 subid = "${module.network.sub_id}"
 sub2id = "${module.network.sub_id2}"
  # niid = "${module.network.interface_id}"
 # host = "${module.instance.instance_ips}"
  private_key = "${file(var.pathofkey)}"
  #sourcepath = "${file("E:/index")}"
  source = "./ec2"
  
}

#module "s3bucket" {
#  bucketname = "${var.bucketname}"
#  source = "./s3"
  
#}

/*module "LB" {
  #server1 = "${module.instance.instanceid}"
 # server2 = "${module.instance.instance_ips2}"
  sg = "${module.network.sg_out_id}"
  sub = ["${module.network.sub_id}", "${module.network.sub_id2}"]
 # bucket = "${module.s3bucket.bucket}"
  vpc = "${module.network.vpc_id}"
  instances = "${module.instance.instanceid}"
  source = "./loadbalancer"
  
}*/








