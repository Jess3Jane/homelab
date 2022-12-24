variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "region" {}

provider "oci" {
   tenancy_ocid = "${var.tenancy_ocid}"
   user_ocid = "${var.user_ocid}"
   region = "${var.region}"
}
