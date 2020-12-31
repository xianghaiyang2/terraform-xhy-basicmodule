

resource "alicloud_slb" "slb" {
  count = "${var.use_slb_module ? 1 : 0}"
  name = "${var.slb_name}"
  address_type = "${var.address_type}"                       # 公网地址还是内网地址（有交换机的时候直接忽略）
  specification = "${var.specification}"                     # 规格
//  master_zone_id = "${var.master_zone_id}"
//  slave_zone_id = "${var.slave_zone_id}"
  delete_protection = "${var.delete_protection}"             # 取消删除保护
  internet_charge_type = "${var.internet_charge_type}"       # 后付费
  vswitch_id = element(distinct(compact(concat(var.vswitch_ids))), 0)
  tags = "${var.tags}"
}


data "alicloud_slbs" "slb" {
  tags = "${var.tags}"
  depends_on = [alicloud_slb.slb]

}

resource "alicloud_slb_listener" "listen" {
  count = "${var.use_slb_module ? 1 : (var.delete_protection ? 1 : 0) }"
  load_balancer_id = "${data.alicloud_slbs.slb.slbs.0.id}"
  frontend_port = 80
  backend_port = 80
  protocol = "http"
  bandwidth = -1

  sticky_session = "on"              # 会话保持
  sticky_session_type = "insert"     # 如果sticky_session_tuype设置为on，该值必须设置
  cookie_timeout = 10080
  cookie = "containscharacterssuchasASCIIcodes"

  health_check = "on"
  health_check_connect_port = 80
  health_check_http_code = "http_2xx,http_3xx"
}


resource "alicloud_slb_attachment" "connect" {
  count = "${var.use_slb_module ? 1 : (var.delete_protection ? 1 : 0)}"
  load_balancer_id = "${data.alicloud_slbs.slb.slbs.0.id}"
  instance_ids     = "${var.instance_id}"   #  后来
}






