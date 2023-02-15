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

resource "oci_core_instance" "instances" {
  for_each = var.instances
  availability_domain = each.value.availability_domain
  compartment_id = var.compartment_ocid
  create_vnic_details {
    subnet_id = oci_core_subnet.subnet.id
    assign_public_ip = true
    hostname_label = each.key
  }
  display_name = each.key
  fault_domain = "FAULT-DOMAIN-1"
  shape = each.value.shape
  source_details {
    source_id = each.value.image
    source_type = "image"
  }
  extended_metadata = {
    ssh_authorized_keys = var.public_key
  }
}

resource "oci_core_internet_gateway" "gateway" {
  display_name = "Homelab Gateway"
  vcn_id = oci_core_subnet.subnet.id
  compartment_id = var.compartment_ocid
}

resource "oci_core_route_table" "route_table" {
  display_name = "Homelab Gateway"
  vcn_id = oci_core_subnet.subnet.id
  compartment_id = var.compartment_ocid
  route_rules {
    cidr_block = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.gateway.id
  }
}
