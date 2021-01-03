output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vswitch_ids" {
  value = module.vpc.vswitch_ids
}

output "instance_ids" {
  value = module.ecs.instance_ids
}

output "slb_id" {
  value = module.slb.slb_id
}

output "eip_id" {
  value = module.eip.eip_id
}

output "eip_ip_address" {
  value = module.eip.eip_ip_address
}

output "ids" {
  value = module.mongo.ids
}