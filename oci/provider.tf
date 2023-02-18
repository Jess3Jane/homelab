variable "compartment_ocid" {}
variable "region" {}
variable "tenancy_ocid" {}
variable "gandi_api_key" {}

provider "oci" {
   tenancy_ocid = "${var.tenancy_ocid}"
   region = "${var.region}"
}

provider "gandi" {
  key = "${var.gandi_api_key}"
}
