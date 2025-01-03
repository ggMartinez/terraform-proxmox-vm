resource "proxmox_vm_qemu" "vm" {
  name       = var.Name
  vmid       = var.VmId
  target_node = var.TargetNode
  clone      = var.Template       # Clone from a template
  full_clone = var.FullClone
  os_type = "cloud-init"
  cores   = 2
  memory  = 2048
  scsihw  = "virtio-scsi-pci"
  agent   = 1

  disk {
    size    = var.DiskSize
    storage = var.DiskStorage
    slot = "scsi1"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }


  ipconfig0 = "ip=${var.IpAddress}/${var.Netmask},gw=${var.Gateway}"  # Use cloud-init configuration for networking
  ssh_user = "root"
}
