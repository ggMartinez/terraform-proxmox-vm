resource "proxmox_vm_qemu" "vm" {
  name = var.Name
  vmid = var.VmId
  target_node = var.TargetNode
  clone = var.Template
  full_clone = var.FullClone
  os_type = "cloud-init"
  cpu_type = "host"
  cores = 2
  memory = 2048
  scsihw = "virtio-scsi-pci"
  agent = 1
  sshkeys = var.SshKeys
  ipconfig0 = "ip=${var.IpAddress}/${var.Netmask},gw=${var.Gateway}"
  tags = var.CustomTags ? "${var.CommonTags},${var.CustomTags}" : "${var.CommonTags}"

  serial {
    id = 0
  }

  disks {
    scsi {
      scsi0 {
        disk {
          storage = var.DiskStorage
          size = var.DiskSize
        }
      }
    }
    ide {
      ide1 {
        cloudinit {
          storage = var.DiskStorage
        }
      }
    }
  }

  network {
    id = 0
    bridge = "vmbr0"
    model = "virtio"
  }

  provisioner "local-exec" {
    command = (
        format(
          "%s %s",
          var.ProvisionAnsible ? <<-EOT
            export ANSIBLE_HOST_KEY_CHECKING=False
            cd ${path.module}/Ansible
            sleep ${var.ProvisionBootWait}
            ANSIBLE_FORCE_COLOR=True \
              ansible-playbook \
                -u ${var.RemoteUser} \
                -i '${self.default_ipv4_address},' \
                --ssh-common-args="-o StrictHostKeyChecking=no" \
                --private-key /tmp/id_rsa \
                -e "ProvisionDocker=${var.ProvisionDocker}" \
                ${var.ProvisionAnsibleBaseFile}
            EOT
          :
          "",
          var.ProvisionAnsible ? <<-EOT
                %{ for file in var.ProvisionAnsibleCustom ~}
                  ANSIBLE_FORCE_COLOR=True \
                  ansible-playbook \
                  -u ${var.RemoteUser} \
                  -i '${self.default_ipv4_address},' \
                  --ssh-common-args="-o StrictHostKeyChecking=no" \
                  --private-key /tmp/id_rsa \
                  ${file}

                %{ endfor }
          EOT
          :
          ""
        )
    )
  }
}
