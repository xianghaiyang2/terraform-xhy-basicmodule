

## 目录

* [参数模板](https://github.com/xianghaiyang/terraform-xhy-basicmodule/blob/master/README.md#%E5%8F%82%E6%95%B0%E6%A8%A1%E6%9D%BF)
* [官网 ](https://www.terraform.io/)
* [一、 认证配置](https://github.com/xianghaiyang/terraform-xhy-basicmodule/blob/master/README.md#%E4%B8%80%E8%AE%A4%E8%AF%81%E9%85%8D%E7%BD%AE)
* [二、 运行](https://github.com/xianghaiyang/terraform-xhy-basicmodule/blob/master/README.md#%E4%BA%8C-%E8%BF%90%E8%A1%8C)
* [三、 Tips](https://github.com/xianghaiyang/terraform-xhy-basicmodule/blob/master/README.md#%E4%B8%89tips)
* [四、 Input ](https://github.com/xianghaiyang/terraform-xhy-basicmodule/blob/master/README.md#%E5%9B%9B-inputs)




## 参数模板
```hcl
module "basicmodule" {
  source  = "git::https://github.com/xianghaiyang/terraform-xhy-basicmodule.git"
 
  profile = "default"
===============分割线===================
  #resource management
  delete_protection   = false
  use_vpc_module      = true
  use_ecs_module      = false
  use_slb_module      = false
  use_eip_module      = false
  use_mongo_module    = false
===============分割线===================
  #which_bucket_for_uploading = 1
  ecs_count           = 3
  mongo_count         = 2
  eip_count           = 2
===============分割线===================
  tags = {
    name   = "xhy"
    team  = "devops"
    forwhat = "test"
  }
  
================资源分割线=================
  #VPC
  availability_zones = {
    check0       = "cn-chengdu-a"
    check1       = "cn-chengdu-b"
  }
  cidr_blocks = {
    check0       = "172.16.2.0/24"
    check1       = "172.16.1.0/24"
  }
  vpc_cidr       = "172.16.0.0/12"
  vpc_name       = "xhy_test"
  vswitch_name   = "xhy_test"
  
================资源分割线==================
  #ECS
  image_owners = "system"
  image_name = "^centos_7_06_64"
  ecs_name = "xhy_test"
  ecs_type = "ecs.s6-c1m1.small"
  key_name = "xianghaiyang_key_pair"
  ecs_internet_charge_type = "PayByTraffic"
  ecs_instance_charge_type = "PostPaid"
  internet_max_bandwidth_out = 0
  disk_category = "cloud_efficiency"
  #disk_size = "0"
  system_disk_size = "40"
  security_group_name = "xhy_test"
  nic_type = "intranet"
  #ecs_vswitch_id = "vsw-2vcljf0565s7qny6bwdur"
  
================资源分割线=================
#SLB
  slb_name = "xhy_test"
  #master_zone_id = "cn-chengdu-a"
  #slave_zone_id = "cn-chengdu-b"
  address_type = "intranet"
  specification = "slb.s2.small"
  internet_charge_type = "PayByTraffic"
  #slb_vswitch_id = ""



================资源分割线=================
  #mongo
  mongo_name = "xhy_test"
  mongo_instance_class = "dds.mongo.mid"
  mongo_instance_storage = "10"
  mongo_replication_factor = "3"
  mongo_account_password = "Xhy18473962265"
  mongo_engine_version = "4.2"
  #mongo_vswitch_id = ""
  
================资源分割线=================
  #EIP
  eip_name                    = "xhy_test"
  eip_internet_charge_type    = "PayByTraffic"

  bandwidth                   = "2"
  isp                         = "BGP"
  eip_instance_charge_type    = "PostPaid"
  instance_ids               = ["i-2vcaftjuyjwcic78gggi", "i-2vch1w0uwx9qqa053urj"]
  eip_tags = {
    name   = "haode"
    team  = "haode"
    forwhat = "haode"
  }

}

 
```
<br>

## 一、认证配置

   该项目使用环境变量进行认证
  
    #set terraform environment
    #export ALICLOUD_ACCESS_KEY="授权码"
    #export ALICLOUD_SECRET_KEY="密钥"
    #export ALICLOUD_REGION="cn-chengdu"

    #set terraform Log
    #export TF_LOG=WARN   # DEBUG INFO WARN ERROR 几个日志级别
    #export TF_LOG_PATH=/home/ubuntu/Desktop/terraform-xhy-basicmodule-client/log/error.log
  <br>
  set terraform init 加速

  如果没有缓存文件要手动创建$HOME/.terraform.d/plugin-cache文件——测试有效
  
    #export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
  
<br>

## 二、 运行

   认证配置后，将参数复制到任意目录如： ~/project/main.tf。根据需求定义相关参数。
   
   执行:
	 
    #terraform init                           # 初始化（拉取GitHub源码，拉取alicloudAPI至你的工作根目录于.terraform中，所以若发生源码修改，必须删除.terraform文件重新初始化）
    #terraform plan                           # 查看资源计划
    #terraform apply                          # 执行/修改 你的资源结构
    #terraform state list                     # 查看你的资源结构，并获取到 “结构路径”
    #terraform destroy -target=“结构路径”      # 通过结构路径释放指定资源
    #terraform destroy                        # 释放所有资源
    #terraform apply -auto-approve            # 跳过yes确认直接执行
    
<br>    

## 三、Tips
    
   ①创建及释放：   资源的创建顺序需满足依赖逻辑，例如，创建了vswitch后，才能建立ECS。同时释放顺序也需要满足依赖逻辑。创建多个资源时，会根据你提供的命名进行“排序命名”
   
   ②关于付费：     部分资源均有internet_charge_type（Internet charge type of the instance, Valid values are PayByBandwidth, PayByTraffic. Default to PayByBandwidth. From version 1.7.1, default to PayByTraffic. It is only PayByBandwidth when instance_charge_type is PrePaid）、instance_charge_type（instance charge type. Valid values are "PrePaid" and "PostPaid". Default to "PostPaid"）两个参数。即instance_charge_type = PostPaid 时 internet_charge_type = PayByTraffic； instance_charge_type = PrePaid 时 internet_charge_type = PayByBandwidth
   
   ③关于vpc：      后台逻辑支持创建一个vpc，之后的基本所有资源都是在该vpc下，如若同一地区还需要建立多个vpc,可新建工作目录更改资源名称等，重新terraform init 
   
   ④关于vswitch：  后台逻辑在每个可用区下均创建一个vswitch，你需要提供该地区下的可用区情况作为参数
   
   ⑤关于ECS：      后台逻辑根据你提供的交换机id，在指定交换机下创建指定数量的ECS。如若未指定交换机，将在随机交换机下创建指定数量的ECS
   
   ⑥关于slb：      后台逻辑根据你提供的交换机id创建一个 内网slb，并自动绑定所有ECS实例。如若未指定交换机，将在随机交换机下创建指定数量的ECS。当address_type选择公网时，交换机会被忽略。即address_type优先级大于slb_vswitch_id
   
   ⑦关于eip：      后台逻辑可创建多个eip，并根据你提供的资源id（可以是NAT网关实例ID、负载均衡SLB实例ID、云服务器ECS实例ID、辅助弹性网卡实例ID、高可用虚拟IP实例ID），给这些资源分别添加弹性公网。注意，创建几个eip，就需要传入几个资源id（注意eip并非vpc下的资源）
   
   ⑧关于mongodb：  后台逻辑根据你提供的交换机id，在指定交换机下创建指定数量的mongo实例。如若未指定交换机，将在随机交换机下创建指定数量的mongo实例



  
<br>  

## 四、 Inputs

    注意： 以下基本所有参数均有后台默认值，但是默认值不一定能成功创建资源。你的参数将覆盖默认值！
    
<br> 
   
**全局参数**
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| source | module的源码位置 | string |复制即可 | yes | 
| region  | 用于设定动作的覆盖地区，如cn-chengdu cn-beijing，如果未传该值，可在环境变量中设置export ALICLOUD_REGION="cn-chengdu" | string  | 'cn-chengdu'  | no  |
| profile  | 集中存放环境变量的文件，如果未设置，可在全局环境变量中设置 | string  | ''  | no  |
| delete_protection  | 是否释放保护，有一定的资源保护能力  | bool  |  false  | no  |
| use_vpc_module | 是否使用vpc资源   | bool  |  true  | no  |
| use_ecs_module  | 是否使用ECS资源 | bool |  true | no  |
| use_slb_module | 是否使用slb资源   | bool  |  true  | no  |
| use_eip_module | 是否使用eip资源   | bool  |  true  | no  |
| use_mongo_module | 是否使用mongodb资源   | bool  | true  | no  |
| ecs_count  | 需要创建ecs实例的数量| int  |  2  |  use_ecs_module设置为true时，该参数有必要设置 |
| eip_count  | 需要创建eip资源的数量| int  |  1  |  use_eip_module设置为true时，该参数有必要设置 |
| mongo_count  | 需要创建mongodb资源的数量  | int  | 1  | use_mongo_module设置为true时，该参数有必要设置  |
| tags | 统一标签   | map  | {name = "xhy",team = "devops",forwhat = "test"} | no  |  

<br>

**VPC**
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| vpc_name | vpc名字| string |  "" | yes |
| vswitch_name | 交换机名字| string  | "" |  yes |
| vpc_cidr_blocks | vpc网段，你需要传入一个vpc网段以创建一个vpc | string  | "172.16.0.0/12" |  yes |
| vswitch_cidr_blocks | 交换机网段,传入几个网段，创建几个交换机   | map  | {check0 = "172.16.2.0/24", check1 = "172.16.1.0/24"} |  yes |
| availability_zones | 交换机的可用区   | map  | {check0 = "cn-chengdu-a", check1 = "cn-chengdu-b"} |  yes |




<br>

**ECS**
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| image_owners | 以镜像所有者查找镜像，可传参数有system, self, others, marketplace | string  | "system" | yes  |
| image_name | 以名字查找镜像 | string  | "^centos_7_06_64" | yes  |
| ecs_name | 所要创建实例命名 | string | "" |  yes |
| ecs_type | 实例规格   | string  | "ecs.s6-c1m1.small" |  no |
| key_name | 密钥对命名   | map  | "" |  yes |
| ecs_internet_charge_type | 支付方式| string  | "PayByTraffic" |  no |
| ecs_instance_charge_type | 购买实例的套餐（后付费）| string  | "PostPaid" | no  |
| internet_max_bandwidth_out | 向公网输出的最大宽带 [0 , 100]| string  | "0" |  no |
| system_disk_category | 系统盘类型   | string  | "cloud_efficiency" |  no |
| system_disk_size | 系统盘大小   | string  | "40" | no  |
| security_group_name | 安全组名称| string  | "" |  yes |
| nic_type | 安全组网络类型internet/intranet| string  | "intranet" |  no |
| ecs_vswitch_id | ecs实例的交换机id | string  | "" | no |

<br>

**SLB**
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| slb_name | slb的命名 | string  | "" |  yes |
| address_type | slb的网络类型可选 internet/intranet | string  | "intranet" | no  |
| specification | slb实例的规格。可选"slb.s1.small", "slb.s2.small", "slb.s2.medium", "slb.s3.small", "slb.s3.medium", "slb.s3.large" and "slb.s4.large" | string | "slb.s2.small" |  no |
| internet_charge_type | 付费类型 If this value is "PayByBandwidth", then argument "internet" must be "true". Default is "PayByTraffic". If load balancer launched in VPC, this value must be "PayByTraffic"  | string  | "PayByTraffic" |  no |
| slb_vswitch_id | slb绑定的交换机id   | string  | "" |  no |


<br>

**Mongodb**
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| mongo_name | mongo的命名 | string  | "" |  yes |
| mongo_instance_class | mongo的[规格](https://www.alibabacloud.com/help/zh/doc-detail/57141.htm) | string  | "dds.mongo.mid" |  no |
| mongo_instance_storage | 实例的储存空间大小[10,2000] | string | "10" |  no |
| mongo_replication_factor | 实例的备用节点数目[3, 5, 7]  | string  | "3" |  no |
| mongo_account_password | root账号的密码It is a string of 6 to 32 characters and is composed of letters, numbers, and underlines   | string  | "" |  yes |
| mongo_engine_version | 数据库引擎版本 3.4、4.0或4.2。 | string | "4.2" | no  |
| mongo_vswitch_id | 数据库绑定的交换机id  | string  | "" | no  |


<br>

**EIP**
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| eip_name | 弹性公网命名 | string  | "" | yes  |
| eip_internet_charge_type | 支付方式 | string  | "PayByTraffic" | no  |
| bandwidth | 公网宽带大小 | string | "2" | no  |
| isp | 弹性公网的行类型，默认为BGP | string  | "BGP" |  no |
| eip_instance_charge_type | 套餐类型，PrePaid/PostPaid，默认为PostPaid | string  | "PostPaid" |  no |
| instance_ids | 需要创建弹性公网的资源id，可以是ECS 、SLB instance 、Nat Gateway | list | ["", ""] |  yes |








