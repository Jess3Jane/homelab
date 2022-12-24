resource "oci_core_vcn" "vcn" {
	compartment_id = var.compartment_ocid
	cidr_blocks = ["172.16.0.0/20"]
	display_name = "HomeLab VCN"
	dns_label = "homelab"
}

resource "oci_core_vlan" "vlan" {
	compartment_id = var.compartment_ocid
	vcn_id = oci_core_vcn.vcn.id
	cidr_block = "172.16.0.0/20"
	availability_domain = var.availability_domain
}

resource "oci_core_instance" "instance_a" {
	availability_domain = var.availability_domain
	compartment_id = var.compartment_ocid
	create_vnic_details {
		hostname_label = "a"
		private_ip = "172.16.0.2"
		vlan_id = oci_core_vlan.vlan.id
	}
	display_name = "instance-a"
	fault_domain = "FAULT-DOMAIN-1"
	shape = var.amd_shape
	source_details {
		source_id = var.amd_image
		source_type = "image"
	}
}
