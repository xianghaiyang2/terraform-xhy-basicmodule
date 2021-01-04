

## 参数传入
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
**一、 认证配置** 

    该项目使用环境变量进行认证
  
    #set terraform environment
    #export ALICLOUD_ACCESS_KEY="授权码"
    #export ALICLOUD_SECRET_KEY="密钥"
    #export ALICLOUD_REGION="cn-chengdu"

    #set terraform Log
    #export TF_LOG=WARN   # DEBUG INFO WARN ERROR 几个日志级别
    #export TF_LOG_PATH=/home/ubuntu/Desktop/terraform-xhy-basicmodule-client/log/error.log
  
  #set terraform init 加速
  #如果没有缓存文件要手动创建$HOME/.terraform.d/plugin-cache文件——测试有效
  
    #export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
  
  
**二、 基本使用**

    将参数复制到任意目录如： ~/project/main.tf


## Conditional creation

  资源的创建及删除建议在开关中设置，而不是destroy。以下参数及资源开关：
  
  只创建VPC:
```hcl
 {
  delete_protection   = false    # 资源保护
  use_vpc_module      = true
  use_ecs_module      = false
  use_slb_module      = false
  use_eip_module      = false
  use_mongo_module    = false

  }
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| region  | The region ID used to launch this module resources. If not set, it will be sourced from followed by ALICLOUD_REGION environment variable and profile | string  | ''  | no  |
| profile  | The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable. | string  | ''  | no  |
| rds_count  | The number of rds to be created.  | int  | 2  | if using rds module,it should be set.  |
| ecs_count  | The number of ecs to be created.| int  | 2  | if using ecs module,it should be set.   |
| use_ecs_module  | Whether to use ecs sub-module.  | bool | true | no  |
| use_eip_module  | Whether to use eip sub-module.   | bool  | true  | no  |
| use_kms_module  | Whether to use kms sub-module.   | bool  | true  | no  |
| use_oss_module  | Whether to use oss sub-module.   | bool  | true  | no  |
| which_bucket_for_uploading  | Due to which bucket for uploading,if you set 1 that means the first bucket you created.   | int  | 1  | if using oss module,it should be set  |
| use_ram_module  | Whether to use ram sub-module.   | bool  | true  | no  |
| use_rds_module  | Whether to use rds sub-module.   | bool  | true  | no  |
| use_slb_module  | Whether to slb kms sub-module.   | bool  | true  | no  |
| use_vpc_module  | Whether to vpc kms sub-module.   | bool  | true  | no  |
| tag  | A mapping of tags to assign to all resources if it can be set tag.   | map  | { app   = "客户端",owner = "bestpractice",team  = "rds",name  = "arthur" }  | no  |
| availability_zones  | The availability zones for vpc,it can be set one or more. | map  | {   az0 = "cn-shanghai-e",az1 = "cn-shanghai-f",az2 = "cn-shanghai-g"} | no  |
| cidr_blocks  | The cidr_block for vswitch,it can be set one or more. | map  | {az0 = "10.99.0.0/21",az1 = "10.99.8.0/21",az2 = "10.99.16.0/21"}  | no  |
| vpc_name  | The name of the VPC.   | string  | "webserver"  | no  |
| vpc_cidr  | The CIDR block for the VPC. | string  | '10.99.0.0/19'  | no |
| slb_name  | The name of the SLB. This name must be unique within your AliCloud account, can have a maximum of 80 characters, must contain only alphanumeric characters or hyphens, such as "-","/",".","_", and must not begin or end with a hyphen. If not specified, Terraform will autogenerate a name beginning with tf-lb.  | string  | 'auto_named_slb'  | no  |
| master_zone_id  | he primary zone ID of the SLB instance. If not specified, the system will be randomly assigned. You can query the primary and standby zones in a region by calling the DescribeZone API. | string  | "cn-shanghai-f" | no  |
| slave_zone_id  | The standby zone ID of the SLB instance. If not specified, the system will be randomly assigned. You can query the primary and standby zones in a region by calling the DescribeZone API. | string  | "cn-shanghai-g" | no  |
| address_type  | The network type of the SLB instance. Valid values: ["internet", "intranet"]. If load balancer launched in VPC, this value must be "intranet".  | string  | "intranet" | no  |
| specification  | The specification of the Server Load Balancer instance. Default to empty string indicating it is "Shared-Performance" instance. Launching "Performance-guaranteed" instance, it is must be specified and it valid values are: "slb.s1.small", "slb.s2.small", "slb.s2.medium", "slb.s3.small", "slb.s3.medium", "slb.s3.large" and "slb.s4.large".  | string | "slb.s2.small" | no  |
| delete_protection  | Whether enable the deletion protection or not. on: Enable deletion protection. off: Disable deletion protection. Default to off. Only postpaid instance support this function. | string  | "off"  | no  |
| instance_type  | DB Instance type.   | string  | "rds.mysql.s3.large" | no  |
| rds_name  | The name of DB instance. It a string of 2 to 256 characters. | string  | "rds" | no  |
| count_format  | The format of number of rds,such as rds01,rds02... | string  | '%02d' | no  |
| engine_version  | Database version. Value options can refer to the latest docs CreateDBInstance EngineVersion.  | string  | '5.7'  | no  |
| engine  | Database type. Value options: MySQL, SQLServer, PostgreSQL, and PPAS.  | string  | 'MySQL'  | no  |
| instance_storage | User-defined DB instance storage space. | string | "100" | no |
| instance_charge_type  | Valid values are Prepaid, Postpaid, Default to Postpaid. Currently, the resource only supports PostPaid to PrePaid.  | string  | "Postpaid"  | no  |
| rds_zone_id  | The Zone to launch the DB instance. From version 1.8.1, it supports multiple zone. If it is a multi-zone and vswitch_id is specified, the vswitch must in the one of them. The multiple zone ID can be retrieved by setting multi to "true" in the data source alicloud_zones.  | string  | "cn-shanghai-MAZ5(f,g)"  | no  |
| db_description  |  Database description. It cannot begin with https://. It must start with a Chinese character or English letter. It can include Chinese and English characters, underlines (_), hyphens (-), and numbers. The length may be 2-256 characters.  | string  | ''  | no  |
| rds_account_name  | Operation account requiring a uniqueness check. It may consist of lower case letters, numbers, and underlines, and must start with a letter and have no more than 16 characters.  | string  | 'myuser'  | no  |
| rds_account_pwd  | Operation password. It may consist of letters, digits, or underlines, with a length of 6 to 32 characters. You have to specify one of password and kms_encrypted_password fields.  | string  | 'Test1234'  | no  |
| account_type  | Privilege type of account.The value can be 'Super','Normal'  | string  | 'Supper'  | no  |
| account_name  | Operation account requiring a uniqueness check. It may consist of lower case letters, numbers, and underlines, and must start with a letter and have no more than 16 characters.  | string  | 'miniapp'  | no  |
| character_set  |  Character set. MySQL: [ utf8, gbk, latin1, utf8mb4 ],SQLServer: [ Chinese_PRC_CI_AS, Chinese_PRC_CS_AS, SQL_Latin1_General_CP1_CI_AS, SQL_Latin1_General_CP1_CS_AS, Chinese_PRC_BIN ]  | string  | 'utf8'  | no  |
| account_privilege  | he privilege of one account access database. Valid values: ["ReadOnly", "ReadWrite"].  | string  | 'ReadWrite'  |  no |
| user_name  | Name of the RAM user. This name can have a string of 1 to 64 characters, must contain only alphanumeric characters or hyphens, such as "-",".","_", and must not begin with a hyphen.  | string  | 'test1121'  |  no |
| mfa_bind_required  | This parameter indicates whether the MFA needs to be bind when the user first logs in. | bool| false | no |
| password_reset_required  | This parameter indicates whether the password needs to be reset when the user first logs in.  | bool  | true  | no  |
| password  | Password of the RAM user. | string  | "Test1234!" | no |
| group_name  | Name of the RAM group. This name can have a string of 1 to 64 characters, must contain only alphanumeric characters or hyphen "-", and must not begin with a hyphen. | string  | 'app_dev_xy'  | no |
| group_comments  | Comment of the RAM group. This parameter can have a string of 1 to 128 characters. | string  | 'app开发用户组'  | no |
| force  | This parameter is used for resource destroy.  | bool  | true  | no |
| ak_status  | Status of access key. It must be Active or Inactive. | string  | "Active"  | no |
| secret_file  | The name of file that can save access key id and access key secret. Strongly suggest you to specified it when you creating access key, otherwise, you wouldn't get its secret ever. | string  | ""  | no |
| policy_name  | Names of the RAM policy. This name can have a string of 1 to 128 characters, must contain only alphanumeric characters or hyphen "-", and must not begin with a hyphen. | map  | { policy_name1 = "AliyunOSSFullAccess",policy_name2 = "AliyunECSFullAccess"} | no |
| policy_type  |  Type of the RAM policy. | map  | { policy_type1 = "System",policy_type2 = "System" }  | no |
| sse_algorithm  | server-side encryption method,it can be "AES256", "KMS" | string  | "AES256"  | no  |
| bucket_names  | The name of the bucket. if you want to create more buckets,you can add key value to the map. | map(string)  | {buc0 = "apptest-xy1234"}  | no  |
| bucket_acls  | The canned ACL to apply. if you want to have more buckets,you can add key value to the map for acls. | map  | { buc0 = "private" }  | no  |
| bucket_storage_classes  | The storage class to apply. Can be "Standard", "IA" and "Archive". if you want to have more buckets,you can add key value to the map for storage classes.  | map  | { buc0 = "Standard" } | no  |
| logging_target_prefix  | To specify a key prefix for log objects. | string  | 'log/'' | no  |
| object_key  | The name of the object once it is in the bucket. if you want to upload more objects, you can add key value to the map. | map  | { } |  no |
| object_source  | The path to the source file being uploaded to the bucket.if you want to upload more objects, you can add key value to the map. | map  | {} | no  |
| description  | The description of the key as viewed in Alicloud console. | string  | "KMS for OSS"  | no  |
| deletion_window_in_days  | Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days.  | string  | "7"  | no  |
| is_enabled  | Specifies whether the key is enabled.  | bool | true  | no  |
| eip_internet_charge_type  | Internet charge type of the EIP, Valid values are PayByBandwidth, PayByTraffic. Default to PayByBandwidth. From version 1.7.1, default to PayByTraffic. It is only PayByBandwidth when instance_charge_type is PrePaid. | string  | "PayByTraffic" | no  |
| bandwidth  | Maximum bandwidth to the elastic public network, measured in Mbps (Mega bit per second). If this value is not specified, then automatically sets it to 5 Mbps. | string  | "2" | no  |
| isp  | The line type of the Elastic IP instance. Default to BGP. Other type of the isp need to open a whitelist. | string  | "BGP"  | no  |
| eip_instance_charge_type  | Elastic IP instance charge type. Valid values are "PrePaid" and "PostPaid".   | "PostPaid"  | no  |
| ecs_count_format  | The number format of ecs count. | string  | "%02d"  | no |
| image_owners  | Filter results by a specific image owner. Valid items are system, self, others, marketplace. | string  | 'system'  | no |
| image_name  | A regex string to filter resulting images by name.  | string  | "^centos_7_06_64"  | no |
| ecs_name  |  The name of the ECS. This instance_name can have a string of 2 to 128 characters, must contain only alphanumeric characters or hyphens, such as "-",".","_", and must not begin or end with a hyphen, and must not begin with http:// or https://. If not specified, Terraform will autogenerate a default name is ECS-Instance. | string  | "test"  | no |
| ecs_type  | The type of instance to start. When it is changed, the instance will reboot to make the change take effect. | string  | "ecs.c5.large" | no |
| key_name  |  The name of key pair that can login ECS instance successfully without password. If it is specified, the password would be invalid. | string  | "xianwang_key_pair_1121"  | no |
| ecs_internet_charge_type  | Internet charge type of the instance, Valid values are PayByBandwidth, PayByTraffic. | string  | "PayByTraffic"  | no  |
| ecs_instance_charge_type  | Valid values are PrePaid, PostPaid. | string  | "PostPaid" | no  |
| internet_max_bandwidth_out  | Maximum outgoing bandwidth to the public network, measured in Mbps (Mega bit per second). Value range: [0, 100].  | int  | 0 | no  |
| deletion_protection  | Whether enable the deletion protection or not.  | bool  | false | no  |
| disk_category  | Category of the disk. Valid values are cloud, cloud_efficiency, cloud_ssd, cloud_essd. | string  | "cloud_efficiency" | no  |
| disk_size  | The size of the data disk in GiBs. When resize the disk, the new size must be greater than the former value, or you would get an error InvalidDiskSize.TooSmall. | string  | "0" |  no |
| system_disk_size  | The size of the system disk in GiBs. | string  | "40"| no  |
| security_group_name  | The name of the security group.  | string  | "ali-sg-ec-sz"  | no  |
| nic_type  | Network type, can be either internet or intranet.  | string  | "intranet" | no  |





