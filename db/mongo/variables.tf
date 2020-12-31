variable "use_mongodb_module" {}

variable "instance_count" {}

variable "instance_name" {}

variable "db_instance_class" {}

variable "db_instance_storage" {}

variable "replication_factor" {}

variable "instance_charge_type" {}

variable "vswitch_ids" {
  description = "它是一个[]"
}

variable "account_password" {}

variable "security_ip_list" {}

variable "engine_version" {}

//variable "backup_time" {}

//variable "backup_period" {}

variable "delete_protection" {}

variable "tags" {}

variable "count_format" {}
