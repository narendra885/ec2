variable "amiid" {
    default = "ami-0d5d9d301c853a04a"
}
variable "instancetype" {
    default = "t2.micro"
}

variable "keyname" {
    
}
variable "name" {
  
}

#variable "Networkname" {
 #   default = "terranew"
#}
variable "cidrvpc" {
    default = "20.0.0.0/16"
}
variable "cidrsubnet" {
    default = "20.0.1.0/24"
}
variable "cidrsubnet2" {
  default = "20.0.2.0/24"
}


variable "portnumbers" { 


}
variable "protocol" {
    default = "tcp"
}
#variable "bucketname" {}
variable "pathofkey" {
  
}
