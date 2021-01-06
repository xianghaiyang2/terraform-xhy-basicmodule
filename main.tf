//adfadfaf
provider "alicloud" {
  version = "1.108.0"
  region = "${var.region}"
  profile = "${var.profile}"
//  configuration_source = "xianghaiyang/terraform-xhy-basicmodule"
}

module "vpc" {
  source = "./vpc"
  use_vpc_module = "${var.use_vpc_module}"
  vpc_cidr = "${var.vpc_cidr_blocks}"
  vpc_name = "${var.vpc_name}"
  vswitch_name = "${var.vswitch_name}"
  cidr_blocks = "${var.vswitch_cidr_blocks}"
  availability_zones = "${var.availability_zones}"
  tags               = "${var.tags}"
  count_format = "${var.count_format}"
}



module "ecs" {
  source = "./ecs"
  ecs_count = "${var.ecs_count}"
  use_ecs_module = "${var.use_ecs_module}"
  vpc_id = "${module.vpc.vpc_id}"                                # 这里是引用别的module资源，途径是output
  vswitch_ids = "${var.ecs_vswitch_id != "" ? [var.ecs_vswitch_id] : module.vpc.vswitch_ids}"          # 这里是引用别的module资源，途径是output
  availability_zones = "${module.vpc.availability_zones}"
  security_group_name = "${var.security_group_name}"
  nic_type = "${var.nic_type}"
  ecs_type = "${var.ecs_type}"
  delete_protection = "${var.delete_protection}"
  ecs_instance_charge_type = "${var.ecs_instance_charge_type}"
  disk_size = "${var.disk_size}"
  system_disk_size = "${var.system_disk_size}"
  ecs_internet_charge_type = "${var.ecs_internet_charge_type}"
  ecs_name = "${var.ecs_name}"
  image_name = "${var.image_name}"
  image_owners = "${var.image_owners}"
  key_name = "${var.key_name}"
  disk_category = "${var.system_disk_category}"
  tags = "${var.tags}"
  count_format = "${var.count_format}"
  internet_max_bandwidth_out = "${var.internet_max_bandwidth_out}"

}


module "slb" {
  source = "./slb"
  use_slb_module = "${var.use_slb_module}"
  slb_name = "${var.slb_name}"
  address_type = "${var.address_type}"
  specification = "${var.specification}"
  delete_protection = "${var.delete_protection}"
  internet_charge_type = "${var.internet_charge_type}"
  vswitch_ids = "${var.slb_vswitch_id != "" ? [var.slb_vswitch_id] : module.vpc.vswitch_ids}"    # 传值则用值创建，否则就用第一台创建
  tags = "${var.tags}"
  instance_id = "${module.ecs.instance_ids}"
}



module "mongo" {
  source = "./db/mongo"
  use_mongodb_module = "${var.use_mongo_module}"
  instance_count   = "${var.mongo_count}"
  instance_name = "${var.mongo_name}"
  db_instance_class = "${var.mongo_instance_class}"
  db_instance_storage = "${var.mongo_instance_storage}"
  replication_factor = "${var.mongo_replication_factor}"
  instance_charge_type = "${var.mongo_instance_charge_type}"
  vswitch_ids  = "${var.mongo_vswitch_id != "" ? [var.mongo_vswitch_id] : module.vpc.vswitch_ids}"
  account_password = "${var.mongo_account_password}"
  security_ip_list = "${module.vpc.vpc_cidr_block}"
  engine_version = "${var.mongo_engine_version}"
  tags = "${var.tags}"
//  backup_period = "${var.mongo_backup_period}"
//  backup_time = "${var.mongo_backup_time}"
  count_format = "${var.count_format}"
  delete_protection = "${var.delete_protection}"
}



module "eip" {
  source = "./eip"
  use_eip_module = "${var.use_eip_module}"
  bandwidth = "${var.bandwidth}"
  eip_internet_charge_type = "${var.eip_internet_charge_type}"
  isp = "${var.isp}"
  eip_instance_charge_type = "${var.eip_instance_charge_type}"
  tags = "${var.tags}"
  delete_protection = "${var.delete_protection}"
  eip_count = "${var.eip_count}"
  eip_name = "${var.eip_name}"
  instance_id = "${var.instance_ids}"
  count_format = "${var.count_format}"
}


module "rocketMQ" {
  source = "./rocketmq"
  use_mq_module = var.use_mq_module
  mqtopic_count = var.mqtopic_count
  delete_protection = var.delete_protection
  instance_name = var.instance_name
  instance_description = var.instance_description
  group_description = var.group_description
  tags = var.tags
  group_name = var.group_name
  group_type = var.group_type
  count_format = var.count_format
  topic_name = var.topic_name
  topic_description = var.topic_description
  topic_message_type = var.topic_message_type
}

module "rds" {
  source = "./db/rds"
  use_rds_db = var.use_rds_module
  rds_count = var.rds_count
  delete_protection = var.delete_protection
  engine = var.rds_engine
  engine_version = var.rds_engine_version
  instance_type = var.rds_instance_type
  instance_storage = var.rds_instance_storage
  db_instance_storage_type = var.rds_instance_storage_type
  instance_name = var.rds_instance_name
  vswitch_ids = "${var.mongo_vswitch_id != "" ? [var.mongo_vswitch_id] : module.vpc.vswitch_ids}"
  security_group_ids = module.ecs.security_group_id
  security_ips = ["${module.vpc.vpc_cidr_block}"]
  tags = var.tags
}

