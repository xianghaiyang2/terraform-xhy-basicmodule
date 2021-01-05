
# mongodb的创建并无安全组的添加字段，且出现添加安全组出错的情况。系无安全组
resource "alicloud_mongodb_instance" "mongodb" {
  count                = "${var.use_mongodb_module ? (var.instance_count != 0 ? var.instance_count : (var.delete_protection ? 1 : 0)) : 0}"   # 这里相当于是可以控制数目
  name                 = "${var.instance_name}-${format(var.count_format, count.index+1)}"
  engine_version       = "${var.engine_version}"                         # 引擎版本
  db_instance_class    = "${var.db_instance_class}"                      # 规格
  db_instance_storage  = "${var.db_instance_storage}"                    # 数据库大小 [10,2000]
  replication_factor   = "${var.replication_factor}"                     # 节点数(多节点高可用) 3、5、7
//  zone_id              = "${var.zone_id}"                                # 这个无关紧要
  instance_charge_type = "${var.instance_charge_type}"                   # 付费类型
  vswitch_id           = element(distinct(compact(concat(var.vswitch_ids))), 0)   # 交换机id， 这里的方式和ecs实例一样
  account_password     = "${var.account_password}"                          # 密码
  security_ip_list     = ["${var.security_ip_list}"]                       # 白名单,这里方案是设置成vpc的ip网段

//  backup_time          = "${var.backup_time}"
//  backup_period        = "${var.backup_period}"
  tags                 = "${var.tags}"
}















