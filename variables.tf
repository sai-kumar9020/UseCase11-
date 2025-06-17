variable "region"{
    description = "AWS region for deployment"
    type  = string
    default =  "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default = "t2.medium"
}

 variable "key_name" {
   description = "SSH Key Pair Name for EC2"
   type        = string
   default = "sai"
}

variable "ami_id" {
  description = "ami id"
  type        = string
  default = "ami-084568db4383264d4"
}

variable "vpc_id"{
  description = "vpc id"
  type = string
  default = "vpc-0526ac238210e4180"
}
