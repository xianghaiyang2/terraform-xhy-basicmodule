
resource "alicloud_ons_instance" "rocketmq" {
  count    = var.use_mq_module ? (var.mqtopic_count != 0 ? 1 : (var.delete_protection ? 1 : 0)) : 0
  name     = var.instance_name
  remark   = var.instance_description                              # 描述
  tags     = var.tags
}

resource "alicloud_ons_group" "group_tcp" {
  count       = var.use_mq_module ? (var.mqtopic_count !=0 ? 1 : (var.delete_protection ? 1 : 0)) : 0
  instance_id = alicloud_ons_instance.rocketmq.0.id          # 实例id
  group_id    = "GID-tcp-${var.group_name}-${format(var.count_format, count.index+1)}"                            # 组名已经被group_name代替，一般命名为 "GID_"
  group_type  = element(distinct(compact(concat(var.group_type))), count.index)                           # 指定该组的协议（http, tcp）这里要轮循两者都要创建
  remark      = var.group_description                         # 组描述
  tags        = var.tags
}


resource "alicloud_ons_topic" "topic" {
  count        = var.use_mq_module ? (var.mqtopic_count != 0 ? var.mqtopic_count : (var.delete_protection ? 1 : 0)) : 0
  instance_id  = alicloud_ons_instance.rocketmq.0.id    # 实例id
  topic        = "${var.topic_name}-${format(var.count_format, count.index+1)}"
  message_type = var.topic_message_type              # 消息类型 https://www.alibabacloud.com/help/zh/doc-detail/29591.html
  remark       = var.topic_description                 # topic描述
  tags         = var.tags
}












