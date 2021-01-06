output "instance_ids" {
  value = "${alicloud_instance.instance.*.id}"
}

output "security_group_id" {
  value = alicloud_security_group.group.*.id
}