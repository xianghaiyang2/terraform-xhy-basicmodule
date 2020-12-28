output "instance_ids" {
  value = "${alicloud_instance.instance.instances.*.id}"
}
