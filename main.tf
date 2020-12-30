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



module "ecs" {
  source = "./ecs"
  ecs_count = "${var.ecs_count}"
  use_ecs_module = "${var.use_ecs_module}"
  vpc_id = "${module.vpc.vpc_id}"                                # 这里是引用别的module资源，途径是output
  vswitch_id = "${var.vswitch_id != "" ? var.vswitch_id : ""}"          # 这里是引用别的module资源，途径是output
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

//module "slb" {
//  source = "./slb"
//  use_slb_module = "${var.use_slb_module}"
//  slb_name = "${var.slb_name}"
//  address_type = "${var.address_type}"
//  specification = "${var.specification}"
//  delete_protection = "${var.delete_protection}"
//  internet_charge_type = "${var.internet_charge_type}"
//  vswitch_id = "${var.vswitch_id != "" ? var.vswitch_id : module.vpc.vswitch_ids[0]}"    # 传值则用值创建，否则就用第一台创建
//  tags = "${var.tags}"
//
//}






//module "eip" {
//  source = "./eip"
//  use_eip_module = "${var.use_eip_module}"
//  bandwidth = "${var.bandwidth}"
//  eip_internet_charge_type = "${var.eip_internet_charge_type}"
//  isp = "${var.isp}"
//  eip_instance_charge_type = "${var.eip_instance_charge_type}"
//  tags = "${var.tags}"
//}