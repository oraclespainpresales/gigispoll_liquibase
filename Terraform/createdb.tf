variable "tenancy_ocid" {}
variable "tenancy_name" {}
variable "user_ocid" {}
variable "api_fingerprint" {}
variable "api_private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "demozone" {}


locals { // Variables locales, modificar con valores ad'hoc !!! 
  vcn_name = "GIGIS_VCN_${var.demozone}"
  vcn_cidr_block = "172.16.0.0/16"
  internet_route_table_name = "internetroutetable_${var.demozone}"
  igw_name = "GIGISGW_${var.demozone}"
}

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

 resource "oci_database_db_system" "DBGIGISPIZZA_${var.demozone}" {
   availability_domain = "VrTN:EU-FRANKFURT-1-AD-1"
   compartment_id = "${var.compartment_ocid}"
   cpu_core_count = "2"
   database_edition = "ENTERPRISE_EDITION_HIGH_PERFORMANCE"
   db_home {
     database {
       "admin_password" = "ZZ0r_cle#1"
       "db_name" = "DB${var.demozone}"
     }
     db_version = "18.6.0.0"
     display_name = "DB${var.demozone}"
   }
   disk_redundancy = "NORMAL"
   shape = "VM.Standard2.1"
   subnet_id = "ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaan3bnuucawng75r6dng5ccf6pim63sbcvojq2rzvus5wonxmi6iya"
   ssh_public_keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCZ8lkqE5MPA6JKNP+85dxBBvGBAgvaVphNdmOUirzoTTS7OmjCIZN9VM/6x81YGEwxnJ7piRZnp0mY/JyzAyKEcgxzbU1N6BGFBEgov6AdXWSpfrcG2vB96OIS8FfAPiPpqMowqeiJXfLYLz9/hiurisAW4t0wXCdqX8mwLtCij67uskQ/CnHP6I4gyYUW1fpGIa8QoPB3vLjW5R0NL/g6LZ7LG5yYXsJZQP6o3wYMBKdvR5Y3rhRmS9mGUwpzebcuy1kpRxeT6ctTqszc88VfSZV+3URBr/vbyJeEt9+3ixTTFJeWH7xuBCXL+k0oZNormgNiovwjssRMJiJxMJjB ccasares@Carloss-MacBook-Pro.local"]
   display_name = "DB${var.demozone}"
   hostname = "hostdb${var.demozone}"
   data_storage_size_in_gb = "512"
   license_model = "BRING_YOUR_OWN_LICENSE"
   node_count = "1"
   
   provisioner "file" {
    source      = "clonepdbs.sh"
    destination = "/home/opc/clonepdbs.sh"
  }

  provisioner "remote-exec" {
    inline = [
	  "sudo cp /home/opc/clonepdbs.sh /home/oracle",
	  "sudo chown oracle:oinstall /home/oracle/clonepdbs.sh",
      "sudo chmod +x /home/oracle/clonepdbs.sh",
	  "sudo su - oracle",
      "/home/oracle/clonepdbs.sh ${var.demozone}",
    ]
  }
 }

 
