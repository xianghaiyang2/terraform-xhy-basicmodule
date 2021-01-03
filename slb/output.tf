output "slb_id" {
  value = data.alicloud_slbs.slb.*.id
}

output "slb_address" {
  value = data.alicloud_slbs.slb.*.address
}
