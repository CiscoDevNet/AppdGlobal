output "apps" {
  value = "${var.appwars}"
}
output "mysql_pass" {
  value = "${var.mysql_pass}"
  sensitive = true
}

output "appport" {
  value = "${var.appport}"
}
output "nbrapm" {
  value = "${var.nbrapm}"
}
output "nbrma" {
  value = "${var.nbrma}"
}
output "nbrsim" {
  value = "${var.nbrsim}"
}
output "nbrnet" {
  value = "${var.nbrnet}"
}
output "root_password" {
  value = "${var.root_password}"
  sensitive = true
}
output "vsphere_user" {
  value = "${var.vsphere_user}"
}
output "vsphere_password" {
  value = "${var.vsphere_password}"
  sensitive = true
}
output "vsphere_server" {
  value = "${var.vsphere_server}"
}
output "datacenter" {
  value = "${var.datacenter}"
}
output "datastore_name" {
  value = "${var.datastore_name}"
}
output "resource_pool" {
  value = "${var.resource_pool}"
}
output "network_name" {
  value = "${var.network_name}"
}
output "template_name" {
  value = "${var.template_name}"
}
output "vm_folder" {
  value = "${var.vm_folder}"
}
output "vm_prefix" {
  value = "${var.vm_prefix}"
}
output "vm_cpu" {
  value = "${var.vm_cpu}"
}
output "vm_memory" {
  value = "${var.vm_memory}"
}
output "vm_domain" {
  value = "${var.vm_domain}"
}
output "vm_count" {
  value = "${var.vm_count}"
}






















