resource "alicloud_vpc" "vpc" {
  count = "${var.use_vpc_module ? 1 : 0}"   # condition ? true_val :false_val 、 var.use_vpc_module输出true, 条件满足count = 1
  name       = "${var.vpc_name}"
  cidr_block = "${var.vpc_cidr}"            # 192.168.0.0/16(must)
  tags       = "${var.tags}"
}

//data "alicloud_zones" "VSwitch" {
//  available_resource_creation = "VSwitch"
//}

resource "alicloud_vswitch" "vswitch" {
  count             = "${var.use_vpc_module ? length(var.cidr_blocks) : 0}"    # 给几个网段就建立几个交换机
  vpc_id            = "${alicloud_vpc.vpc.0.id}"
  # vpc_id(must)
  availability_zone = "${lookup(var.availability_zones,"check${count.index}")}"   # vpc的可用区(must)  count.index—与0此实例相对应的唯一索引号
//  availability_zone = element(${data.alicloud_zones.VSwitch.ids}, count.index)   # vpc的可用区(must)  count.index—与0此实例相对应的唯一索引号

  cidr_block        = "${lookup(var.cidr_blocks, "check${count.index}")}"         # vpc的网段(must)。 count.index—与0此实例相对应的唯一索引号
  tags              = "${var.tags}"

}
# 注：一次性只能添加小于等于 可用区 个数的交换机?

