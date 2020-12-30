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
  vpc_cidr = "${var.vpc_cidr}"
  vpc_name = "${var.vpc_name}"
  vswitch_name = "${var.vswitch_name}"
  cidr_blocks = "${var.cidr_blocks}"
  availability_zones = "${var.availability_zones}"
  tags               = "${var.tags}"
}


//module "rds" {
//  source = "./rds"
//  use_rds_module = "${var.use_rds_module}"
//  vswitch_id = "${module.vpc.vswitch_ids[1]}"
//  vpc_cidr_block = "${module.vpc.vpc_cidr_block}"
//  rds_account_name = "${var.rds_account_name}"
//  character_set = "${var.character_set}"
//  account_privilege = "${var.account_privilege}"
//  rds_count = "${var.rds_count}"
//  account_type = "${var.account_type}"
//  account_name = "${var.account_name}"
//  instance_charge_type = "${var.instance_charge_type}"
//  instance_type = "${var.instance_type}"
//  tags = "${var.tags}"
//  count_format = "${var.count_format}"
//  rds_name = "${var.rds_name}"
//  engine = "${var.engine}"
//  instance_storage = "${var.instance_storage}"
//  rds_account_pwd = "${var.rds_account_pwd}"
//  db_description = "${var.db_description}"
//  rds_zone_id = "${var.rds_zone_id}"
//  engine_version = "${var.engine_version}"
//}
//
module "ecs" {
  source = "./ecs"
  ecs_count = "${var.ecs_count}"
  use_ecs_module = "${var.use_ecs_module}"
  vpc_id = "${module.vpc.vpc_id}"                                # 这里是引用别的module资源，途径是output
  vswitch_ids = "${module.vpc.vswitch_ids}"          # 这里是引用别的module资源，途径是output
  availability_zones = "${module.vpc.availability_zones}"
  security_group_name = "${var.security_group_name}"
  nic_type = "${var.nic_type}"
  ecs_type = "${var.ecs_type}"
  deletion_protection = "${var.deletion_protection}"
  ecs_instance_charge_type = "${var.ecs_instance_charge_type}"
  disk_size = "${var.disk_size}"
  system_disk_size = "${var.system_disk_size}"
  ecs_internet_charge_type = "${var.ecs_internet_charge_type}"
  ecs_name = "${var.ecs_name}"
  image_name = "${var.image_name}"
  image_owners = "${var.image_owners}"
  key_name = "${var.key_name}"
  disk_category = "${var.disk_category}"
  tags = "${var.tags}"
  ecs_count_format = "${var.ecs_count_format}"
  internet_max_bandwidth_out = "${var.internet_max_bandwidth_out}"

}






# module "adb4postgresql" {
#   source             = "./db/adb4postgresql"
#   use_adb4postgresql_module = false
#   instance_count     = 1
#   #################
#   # Instance
#   #################
#   zone_id      = "cn-shanghai-g"
#   vswitch_id   = "${module.vpc.vswitch_ids[1]}"
#   security_ips = ["${module.vpc.vpc_cidr_block}"]
#   tags                = "${var.tags}"
#   instance_name          = "terraform-test"
#   engine               = "gpdb"
#   engine_version       = "6.0"
#   instance_class       = "gpdb.group.segsdx2"
#   instance_group_count = "2"
# }
