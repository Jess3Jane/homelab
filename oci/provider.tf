variable "compartment_oicd" {}
variable "region" {}
variable "tenancy_ocid" {}

provider "oci" {
   tenancy_ocid = "${var.tenancy_ocid}"
   region = "${var.region}"
}
