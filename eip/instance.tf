
resource "alicloud_eip" "eip" {
  count                 = "${var.use_eip_module ? (var.eip_count != 0 ? var.eip_count : (var.delete_protection ? 1 : 0)) : 0}"
  name                  = "${var.eip_name}"
  bandwidth             = "${var.bandwidth}"                           # 宽带值 Mbps
  internet_charge_type  = "${var.eip_internet_charge_type}"            # PayByTraffic
  isp                   = "${var.isp}"                                 # BGP
  instance_charge_type  = "${var.eip_instance_charge_type}"            # PostPaid
  tags                  = "${var.tags}"                                # tags
//  vswitch_id            = element(distinct(compact(concat(var.vswitch_ids))), 0)
}


resource "alicloud_eip_association" "eip_asso" {
  count                 = "${var.use_eip_module ? (var.eip_count != 0 ? var.eip_count : (var.delete_protection ? 1 : 0)) :0}"
  instance_id           = "${var.instance_id}"                         # ECS or SLB instance or Nat Gateway
  allocation_id         = element(distinct(compact(concat(alicloud_eip.eip.*.id))), (count-1).index)
}
