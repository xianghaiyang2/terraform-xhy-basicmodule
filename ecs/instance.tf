
resource "alicloud_security_group" "group" {
  count = "${var.use_ecs_module ? (var.ecs_count != 0 ? 1 : (var.deletion_protection ? 1 : 0)) : 0}"
  name = "${var.security_group_name}"
  vpc_id = "${var.vpc_id}"
  inner_access_policy = "Accept"
  description = "default security group"
}

resource "alicloud_security_group_rule" "rdp" {
  count             = "${var.use_ecs_module ? (var.ecs_count != 0 ? 1 : (var.deletion_protection ? 1 : 0)) : 0}"
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "${var.nic_type}"
  policy            = "accept"
  port_range        = "3389/3389"
  priority          = 1
  security_group_id = "${alicloud_security_group.group.0.id}"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "ssh" {
  count             = "${var.use_ecs_module ? (var.ecs_count != 0 ? 1 : (var.deletion_protection ? 1 : 0)) : 0}"
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "${var.nic_type}"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = "${alicloud_security_group.group.0.id}"
  cidr_ip           = "0.0.0.0/0"
}


resource "alicloud_security_group_rule" "icmp" {
  count             = "${var.use_ecs_module ? (var.ecs_count != 0 ? 1 : (var.deletion_protection ? 1 : 0)) : 0}"
  type              = "ingress"
  ip_protocol       = "icmp"
  nic_type          = "${var.nic_type}"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = "${alicloud_security_group.group.0.id}"
  cidr_ip           = "0.0.0.0/0"
}