
output "ids" {
  value = "${alicloud_mongodb_instance.mongodb.*.id}"
}