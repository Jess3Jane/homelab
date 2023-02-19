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
  dns_label = "main"
  route_table_id = oci_core_route_table.route_table.id
}

resource "oci_core_instance" "instances" {
  for_each = var.instances
  availability_domain = var.availability_domain
  compartment_id = var.compartment_ocid
  create_vnic_details {
    subnet_id = oci_core_subnet.subnet.id
    assign_public_ip = true
    hostname_label = each.key
    nsg_ids = [oci_core_network_security_group.nsg.id]
  }
  display_name = each.key
  fault_domain = each.value.fault_domain
  shape = each.value.shape
  source_details {
    source_id = each.value.image
    source_type = "image"
  }
  extended_metadata = {
    ssh_authorized_keys = var.public_key
  }
  dynamic "shape_config" {
    for_each = each.value.shape_config
    content {
      memory_in_gbs = shape_config.value.memory
      ocpus = shape_config.value.ocpus
    }
  }
}

resource "oci_core_internet_gateway" "gateway" {
  display_name = "Homelab Gateway"
  vcn_id = oci_core_vcn.vcn.id
  compartment_id = var.compartment_ocid
}

resource "oci_core_security_list" "sl" {
  compartment_id = var.compartment_ocid
  vcn_id = oci_core_vcn.vcn.id
  ingress_security_rules {
    protocol = "all"
    source = "172.16.0.0/20"
  }
  egress_security_rules {
    protocol = "all"
    destination = "172.16.0.0/20"
  }
}

resource "oci_core_network_security_group" "nsg" {
  compartment_id = var.compartment_ocid
  vcn_id = oci_core_vcn.vcn.id
}

resource "oci_core_network_security_group_security_rule" "ingress" {
  network_security_group_id = oci_core_network_security_group.nsg.id
  direction = "INGRESS"
  source = "0.0.0.0/0"
  destination = "0.0.0.0/0"
  protocol = "all"
}

resource "oci_core_network_security_group_security_rule" "egress" {
  network_security_group_id = oci_core_network_security_group.nsg.id
  direction = "EGRESS"
  source = "0.0.0.0/0"
  destination = "0.0.0.0/0"
  protocol = "all"
}

resource "oci_core_route_table" "route_table" {
  display_name = "Homelab Gateway"
  vcn_id = oci_core_vcn.vcn.id
  compartment_id = var.compartment_ocid
  route_rules {
    cidr_block = "0.0.0.0/0"

    network_entity_id = oci_core_internet_gateway.gateway.id
  }
}

resource "gandi_livedns_record" "public_instance_records" {
  for_each = var.instances
  name = "${each.key}.lab"
  ttl = 900
  type = "A"
  values = toset([oci_core_instance.instances[each.key].public_ip])
  zone = "dizzywolf.house"
}

resource "gandi_livedns_record" "private_instance_records" {
  for_each = var.instances
  name = "${each.key}.in.lab"
  ttl = 900
  type = "A"
  values = toset([oci_core_instance.instances[each.key].private_ip])
  zone = "dizzywolf.house"
}

resource "gandi_livedns_record" "lab_record" {
  name = "lab"
  ttl = 900
  type = "A"
  values = toset([
    for k, _ in var.instances : oci_core_instance.instances[k].public_ip
  ])
  zone = "dizzywolf.house"
}
