variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "api_fingerprint" {}
variable "api_private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "demozone" {}

provider "oci" {
  tenancy_ocid = "${var.tenancy_ocid}"
  user_ocid = "${var.user_ocid}"
  fingerprint = "${var.api_fingerprint}"
  private_key_path = "${var.api_private_key_path}"
  region = "${var.region}"
}

data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.compartment_ocid}"
}

###
### Database system !!!
###

resource "oci_database_db_system" "DBGIGISPIZZA" {
   availability_domain = "${data.oci_identity_availability_domains.ADs.availability_domains.0.name}"
   compartment_id = "${var.compartment_ocid}"
   cpu_core_count = "2"
   database_edition = "ENTERPRISE_EDITION_HIGH_PERFORMANCE"
   db_home {
     database {
       "admin_password" = "Welcome1#Oc4j1013-"
       "db_name" = "DB${var.demozone}"
     }
     db_version = "19.0.0.0"
     display_name = "DODBHP"
   }
   disk_redundancy = "NORMAL"
   shape = "VM.Standard2.1"
   subnet_id = "ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaanvcqurwidohxzzoa3qla5yomftew4zjz4fsennahxpi745zyqfea"
   ssh_public_keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCZ8lkqE5MPA6JKNP+85dxBBvGBAgvaVphNdmOUirzoTTS7OmjCIZN9VM/6x81YGEwxnJ7piRZnp0mY/JyzAyKEcgxzbU1N6BGFBEgov6AdXWSpfrcG2vB96OIS8FfAPiPpqMowqeiJXfLYLz9/hiurisAW4t0wXCdqX8mwLtCij67uskQ/CnHP6I4gyYUW1fpGIa8QoPB3vLjW5R0NL/g6LZ7LG5yYXsJZQP6o3wYMBKdvR5Y3rhRmS9mGUwpzebcuy1kpRxeT6ctTqszc88VfSZV+3URBr/vbyJeEt9+3ixTTFJeWH7xuBCXL+k0oZNormgNiovwjssRMJiJxMJjB"]
   display_name = "DB${var.demozone}"
   hostname = "hostdb${var.demozone}"
   data_storage_size_in_gb = "512"
   license_model = "BRING_YOUR_OWN_LICENSE"
   node_count = "1"

 }

# Get DB node list
data "oci_database_db_nodes" "db_nodes" {
  compartment_id = "${var.compartment_ocid}"
  db_system_id   = "${oci_database_db_system.DBGIGISPIZZA.id}"
}

# Get DB node details
data "oci_database_db_node" "db_node_details" {
  db_node_id = "${lookup(data.oci_database_db_nodes.db_nodes.db_nodes[0], "id")}"
}

# Gets the OCID of the first (default) vNIC
data "oci_core_vnic" "db_node_vnic" {
    vnic_id = "${data.oci_database_db_node.db_node_details.vnic_id}"
}



resource "null_resource" "remote-exec" {
      connection {
      agent       = false
      timeout     = "30m"
      host        = "${data.oci_core_vnic.db_node_vnic.public_ip_address}"
      user        = "opc"
      private_key = "${file("${var.api_private_key_path}")}"
    }

    provisioner "file" {
                source      = "Terraform/ClonePDBs.sh"
                destination = "/home/opc/ClonePDBs.sh"
         }

         provisioner "file" {
                source      = "Terraform/ClonePDBs.sql"
                destination = "/home/opc/ClonePDBs.sql"
         }
         
         provisioner "file" {
                source      = "Terraform/execDB.sh"
                destination = "/home/opc/execDB.sh"
         }

        
        provisioner "remote-exec" {
                inline = [
                "chmod +x /home/opc/ClonePDBs.sh",
                "/home/opc/ClonePDBs.sh ${var.demozone}",
                ]
        }

  }

output "db_node_public_ip" {
    value = ["${data.oci_core_vnic.db_node_vnic.public_ip_address}"]
}
