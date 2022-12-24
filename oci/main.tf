resource "oci_core_vcn" "vcn" {
	compartment_id = var.compartment_ocid
	cidr_blocks = ["172.16.0.0/20"]
	display_name = "HomeLab VCN"
	dns_label = "homelab"
}
