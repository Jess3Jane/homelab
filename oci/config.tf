terraform {
  required_providers {
    gandi = {
      source = "go-gandi/gandi"
      version = "2.2.3"
    }
    oci = {
      source = "oracle/oci"
      version = "4.108.0"
    }
  }
}
