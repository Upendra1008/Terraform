variable "region" {

  description = "eu-central-1"

  type = string

  default = "eu-central-1"

}



variable "ami" {

  description = "ami-0c541e8575db12991"

  type = string

}



variable "instance_type" {

  description = "t3.micro"

  type = string

}



variable "key_name" {

  description = "debops_11"

  type = string

}
