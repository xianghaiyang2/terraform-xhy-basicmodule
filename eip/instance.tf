

# 一个eip只能绑定一个实例资源
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

  # 支持输入NAT网关实例ID、负载均衡SLB实例ID、云服务器ECS实例ID、
  #  辅助弹性网卡实例ID、高可用虚拟IP实例ID
  instance_id           = element(distinct(compact(concat(var.instance_id))), count.index)
  allocation_id         = element(distinct(compact(concat(alicloud_eip.eip.*.id))), count.index)
}
