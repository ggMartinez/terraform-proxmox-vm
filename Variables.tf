variable "Name" {}
variable "VmId" {default=0}
variable "TargetNode" {}
variable "Template" {default="AlmaLinux20250104"}
variable "FullClone" {default=false}
variable "DiskSize" {default="20G"}
variable "DiskStorage" {default="storage"}
variable "CommonTags" {default="linux,monitor,almalinux"}
variable "CustomTags" {default=null}
variable "IpAddress" {}
variable "SshKeys" {}
variable "Netmask" {default="24"}
variable "Gateway" {default="192.168.1.1"}
variable "UserData" {default=" "}
variable "RemoteUser" {default="almalinux"}
variable "ProvisionAnsible" {default=false}
variable "ProvisionAnsibleBaseFile" {default="BaseAlmaLinux.yml"}
variable "ProvisionAnsibleCustom" {
  type=list(string)
  default=[]
}
variable "ProvisionBootWait" {default=20}
variable "ProvisionDocker" {default="No"}
