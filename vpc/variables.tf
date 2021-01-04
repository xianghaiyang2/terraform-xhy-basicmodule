variable "availability_zones" {

}

variable "vpc_name" {
  description = "vpc名字"
}


variable "vswitch_name" {

}

variable "vpc_cidr" {
  description = "vpc的网段例如：172.16.0.0/12"
}

variable "cidr_blocks" {
  description = "交换机的网段例如：172.16.0.0/24"
}


variable "use_vpc_module" {}

variable "tags" {
  description = "统一标签"

}

variable "count_format" {}