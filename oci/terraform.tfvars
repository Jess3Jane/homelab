instances = {
  "atropos" = {
    fault_domain = "FAULT-DOMAIN-1"
    shape = "VM.Standard.E2.1.Micro"
    image = "ocid1.image.oc1.us-sanjose-1.aaaaaaaaudhtosvzok3k6csi2cnhsee7gfezgnkd7gq742gsoe4xjaxiaoja"
    shape_config = []
  },
  "clotho" = {
    fault_domain = "FAULT-DOMAIN-2"
    shape = "VM.Standard.E2.1.Micro"
    image = "ocid1.image.oc1.us-sanjose-1.aaaaaaaaudhtosvzok3k6csi2cnhsee7gfezgnkd7gq742gsoe4xjaxiaoja"
    shape_config = []
  },
  "lachesis" = {
    fault_domain = "FAULT-DOMAIN-3"
    shape = "VM.Standard.A1.Flex"
    image = "ocid1.image.oc1.us-sanjose-1.aaaaaaaa55gsqdrzvcsnfhyqs4p3ipllgzhasngdml6t3teiradtskjtcxdq"
    shape_config = [{ 
      memory = 24
      ocpus = 4,
    }],
  },
}

availability_domain = "jTyH:US-SANJOSE-1-AD-1"
