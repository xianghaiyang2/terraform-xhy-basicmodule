#ECS


variable "use_ecs_module" {
  description = "是否需要创建实例"
}

variable "ecs_count" {
  description = "ecs实例的数目"
}

variable "vpc_id" {

}




variable "vswitch_ids" {
  description = "请给我列表[]"
}


variable "security_group_name" {

}

variable "availability_zones" {
  type = "list"
}


variable "count_format" {
  description = ""
}

variable "image_owners" {
}

variable "image_name" {

}


variable "ecs_name" {

}

variable "ecs_type" {

}


variable "key_name" {

}

variable "ecs_internet_charge_type" {

}


variable "ecs_instance_charge_type" {

}


variable "internet_max_bandwidth_out" {

}

variable "delete_protection" {

}

variable "tags" {
}

variable "disk_category" {

}

variable "disk_size" {

}

variable "system_disk_size" {

}


variable "nic_type" {

}

