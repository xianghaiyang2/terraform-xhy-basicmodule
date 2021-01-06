
output "rds_instance_id" {
  value = alicloud_db_instance.rds_instance.*.id
}

output "rds_instance_port" {
  value = alicloud_db_instance.rds_instance.*.port
}
