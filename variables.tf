#Main
variable "region" {
  default= "cn-chengdu"
}

variable "profile" {
  description = "The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  default     = "default"
}

#resource management

variable "delete_protection" {
  default = "false"
}


variable "use_vpc_module" {
  default = true
}

variable "use_ecs_module" {
  default = true
}

variable "use_eip_module" {
  default = true
}

variable "use_slb_module" {
  default = true
}

variable "use_mongo_module" {
  default = true
}

variable "use_mq_module" {
  default = true
}


variable "ecs_count" {
  default = 2
}

variable "mongo_count" {
  default = 1
}

variable "eip_count" {
  default = 1
}

variable "mqtopic_count" {
  default = 2
}

variable "count_format" {
  default = "%02d"
}


# ====================VPC==================
# 这特么是交换机的可用区，vpc没有可用区的说法哦
variable "availability_zones" {
  type = "map"
  default = {
    check0 = "cn-chengdu-a"
    check1 = "cn-chengdu-b"
  }
}
# vpc网段
variable "vpc_cidr_blocks" {
  default = "172.16.0.0/12"
}

# 交换机网段
variable "vswitch_cidr_blocks" {
  type = "map"
  default = {
    check0 = "172.16.2.0/24"
    check1 = "172.16.1.0/24"

  }
}

variable "vpc_name" {
  default = "xhy_sfasdftest"
}

variable "vswitch_name" {
  default = "xhy_sfasdftest"
}


# =====================SLB=====================
variable "slb_name" {
  default = "xhy_safasfastest"
}

//variable "master_zone_id" {
//  default = "cn-chengdu-a"
//}
//
//variable "slave_zone_id" {
//  default = "cn-chengdu-b"
//}

variable "slb_vswitch_id" {
  default = ""
}

variable "address_type" {
  default = "intranet"
}

variable "specification" {
  default = "slb.s2.small"
}

variable "internet_charge_type" {
  default = "PayByTraffic"
}

variable "tags" {
  type = "map"
  default = {
    name   = "sdfasf"
    team  = "devopssafafsaf"
    forwhat = "safasdfsafas"

  }
}


# ========================EIP===========================

variable "eip_name" {
  default = "xhy_test"
}

variable "eip_internet_charge_type" {
  default = "PayByTraffic"
}

variable "bandwidth" {
  default = "2"
}

variable "isp" {
  default = "BGP"
}

variable "eip_instance_charge_type" {
  default = "PostPaid"
}


variable "instance_ids" {
  default = []
}

# =========================ECS=========================
variable "image_owners" {
  default = "system"
}

variable "image_name" {
  default = "^centos_7_06_64"
}

variable "ecs_vswitch_id" {
  default = ""
}

variable "ecs_name" {
  default = "xhsdfasfdy_test"
}

variable "ecs_type" {
  default = "ecs.ic5.large"
}

variable "key_name" {
  default = "xhsdzsfzsy_test"
}

variable "ecs_internet_charge_type" {
  default = "PayByTraffic"
}


variable "ecs_instance_charge_type" {
  default = "PostPaid"
}

variable "internet_max_bandwidth_out" {
  default = 0
}

variable "system_disk_category" {
  default = "cloud_efficiency"
}

variable "disk_size" {
  default = "0"
}

variable "system_disk_size" {
  default = "40"
}

variable "security_group_name" {
  default = "xhfsfday"
}

variable "nic_type" {
  default = "intranet"
}

# ==============mongodb===============
variable "mongo_name" {
  default = "xhy_test"
}

variable "mongo_instance_class" {
  default = "dds.mongo.mid"
}

variable "mongo_instance_storage" {
  default = "10"
}

variable "mongo_replication_factor" {
  default = "3"
}

variable "mongo_instance_charge_type" {
  default = "PostPaid"
}

variable "mongo_vswitch_id" {
  default = ""
}

variable "mongo_account_password" {
  default = "Xhy18473962265"
}

variable "mongo_engine_version" {
  default = "4.2"
}


# ==============rocketMQ===============

variable "instance_name" {
  default = "xhy_test"
}

variable "group_name" {
  default = "xhy_test"
}

variable "topic_name" {
  default = "xhy_test"
}

variable "instance_description" {
  default = "instance"
}

variable "group_description" {
  default = "group"
}

variable "topic_description" {
  default = "topic"
}

variable "group_type" {
  default = ["tcp", "http"]
}

variable "topic_message_type" {
  type         = number
  description  = "这是topic接受的消息类型，可选0：普通消息 1：分区顺序消息 2：全局顺序消息 4：事务消息 5：定时/延时消息"
  default      = 0
}



