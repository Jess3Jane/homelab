resource "oci_core_vcn" "vcn" {
	compartment_id = var.compartment_ocid
	cidr_blocks = ["172.16.0.0/20"]
	display_name = "HomeLab VCN"
	dns_label = "homelab"
}

resource "oci_core_subnet" "subnet" {
	cidr_block = "172.16.0.0/20"
	compartment_id = var.compartment_ocid
	display_name = "Homelab VCN Subnet"
	vcn_id = oci_core_vcn.vcn.id
}

resource "oci_core_instance" "atropos" {
	availability_domain = var.availability_domain
	compartment_id = var.compartment_ocid
	create_vnic_details {
		#hostname_label = "atropos"
		private_ip = "172.16.0.2"
		subnet_id = oci_core_subnet.subnet.id
	}
	display_name = "Atropos"
	fault_domain = "FAULT-DOMAIN-1"
	shape = var.amd_shape
	source_details {
		source_id = var.amd_image
		source_type = "image"
	}
	metadata = {
		"ssh_authorized_keys": var.public_key
	}
}
