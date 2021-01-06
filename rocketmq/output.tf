
output "mq_instance_id" {
  value = "${alicloud_ons_instance.rocketmq.*.id}"
}

output "mq_group_id" {
  value = "${alicloud_ons_group.group_tcp.*.id}"
}

output "mq_group_type" {
  value = "${alicloud_ons_topic.topic.*.id}"
}