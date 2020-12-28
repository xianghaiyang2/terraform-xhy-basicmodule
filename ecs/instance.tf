data "alicloud_images" "images_ds" {
  owners     = "${var.image_owners}"     # 镜像来源()全局查询镜像system, self, others, marketplace
  name_regex = "${var.image_name}"       # "^centos_6"  这点说明可以直接查询官方的
}


resource "alicloud_instance" "instance" {

  # 如果打开了 use_ecs_module(bool) 开关，则创建数目由 ecs_count决定(count包括增加/减少)
  # 如果没有打开 use_ecs_module(bool)开关，则ecs实例可用deletion_protection托管，根据需求，可以避免被相关依赖资源删除
  count = "${var.use_ecs_module ? var.ecs_count : (var.deletion_protection ? 1 : 0)}"   # count.index = 0 , 1, 2
  instance_name = "${var.ecs_name}-${format(var.ecs_count_format, count.index+1)}"      # 编号从1开始
//  instance_name = "${var.ecs_name}-${count.index+1}"
  image_id = "${data.alicloud_images.images_ds.images.0.id}"                            # (must)
  instance_type = "${var.ecs_type}"                                                     # (must)
  security_groups = ["${alicloud_security_group.group.0.id}"]                           # (must)
  availability_zone = "${var.availability_zones[count.index+1]}"                        # 个人觉得这里不仅没必要，而且写错了**
  internet_charge_type = "${var.ecs_internet_charge_type}"                              # 网络付费类型
  internet_max_bandwidth_out = "${var.internet_max_bandwidth_out}"                      # 实例公网输出速率0
  instance_charge_type = "${var.ecs_instance_charge_type}"                              # 实例付费类型
  system_disk_category = "${var.disk_category}"                                         # 高效云盘
  system_disk_size = "${var.system_disk_size}"                                          # 数据盘40

  # 拼接字符串列表、去空、去重、列表取count.index(其中取下标会轮循)                              # 自己填一个或者多个
  vswitch_id = "${var.vswitch_ids[count.index+1]}"
//  vswitch_id = element(distinct(compact(concat([var.vswitch_id], var.vswitch_ids))), count.index, )
  tags = "${var.tags}"                                                                  # 好几个标签
  deletion_protection = "${var.deletion_protection}"                                    # 删除保护 false
}


resource "alicloud_key_pair" "pair" {
  count = "${var.use_ecs_module ? (var.ecs_count != 0 ? 1 : 0 )  : 0}"    # 只要创建ecs，就创建一个key_pair
  key_name = "${var.key_name}"
}

data "alicloud_instances" "instance" {
  tags = "${var.tags}"
  depends_on = ["alicloud_instance.instance"]
}

resource "alicloud_key_pair_attachment" "attachment" {
  count = "${var.use_ecs_module ? (var.ecs_count != 0 ? 1 : (var.deletion_protection ? 1 : 0)) : 0}"
  key_name     = "${alicloud_key_pair.pair.0.id}"
  instance_ids = "${data.alicloud_instances.instance.instances.*.id}"
}


resource "alicloud_security_group" "group" {
  count = "${var.use_ecs_module ? (var.ecs_count != 0 ? 1 : (var.deletion_protection ? 1 : 0)) : 0}"
  name = "${var.security_group_name}"
  vpc_id = "${var.vpc_id}"
  inner_access_policy = "Accept"
  description = "default security group"
}

resource "alicloud_security_group_rule" "rdp" {
  count             = "${var.use_ecs_module ? (var.ecs_count != 0 ? 1 : (var.deletion_protection ? 1 : 0)) : 0}"
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "${var.nic_type}"
  policy            = "accept"
  port_range        = "3389/3389"
  priority          = 1
  security_group_id = "${alicloud_security_group.group.0.id}"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "ssh" {
  count             = "${var.use_ecs_module ? (var.ecs_count != 0 ? 1 : (var.deletion_protection ? 1 : 0)) : 0}"
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "${var.nic_type}"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = "${alicloud_security_group.group.0.id}"
  cidr_ip           = "0.0.0.0/0"
}


resource "alicloud_security_group_rule" "icmp" {
  count             = "${var.use_ecs_module ? (var.ecs_count != 0 ? 1 : (var.deletion_protection ? 1 : 0)) : 0}"
  type              = "ingress"
  ip_protocol       = "icmp"
  nic_type          = "${var.nic_type}"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = "${alicloud_security_group.group.0.id}"
  cidr_ip           = "0.0.0.0/0"
}