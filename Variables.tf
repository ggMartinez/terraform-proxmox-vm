variable "Name" {}
variable "VmId" {default=0}
variable "TargetNode" {}
variable "Template" {default="AlmaLinuxLatest"}
variable "FullClone" {default=false}
variable "DiskSize" {default="10G"}
variable "DiskStorage" {default="storage"}
variable "IpAddress" {}
variable "Netmask" {default="24"}
variable "Gateway" {default="192.168.1.1"}
variable "UserData" {default=" "}
