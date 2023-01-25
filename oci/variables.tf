variable "availability_domain" {
	type = string
	default = "jTyh:US-SANJOSE-1-AD-1"
}

variable "amd_shape" {
	type = string
	default = "VM.Standard.E2.1.Micro"
}

variable "amd_image" {
	type = string
	default = "ocid1.image.oc1.us-sanjose-1.aaaaaaaaudhtosvzok3k6csi2cnhsee7gfezgnkd7gq742gsoe4xjaxiaoja"
}

variable "public_key" {
	type = string
	default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1eVH5tVioIhK7A295n1F4hPXpAlLpbXksfutuL4HUf1U4ZfchJmF4ujtiWyDhiIex+ZZMBJNwSeYEHU0Mv58zZ5GhhNJ1pZZ0PRo/sFliRgvgh609YyHmGJJ4tJ4n1gnmDBbR1fy+U7rz22JkGKRdLvJ/tLNfGrV9Wj415HHFKWjNBJ8f3A0npRVVkVZGZAuDWzeELevK/Dt77TCs4rSDTw4hYIHqLxJarrI346KkpSo0Ro55q2IiUX5eptyqYsqPLKpBce+TS0dqJiTrwwq8MmnvupfGPGZP7kGvmOLMsYBdP+R9jGV7dJvwo1BJhSaM1Zy2EbLQvcDjEoe9fnXrsbp4wexDetgkDvjQfP5yQFWCT6Bf0Rw+yUYcN/S/MNLexigmq+BWvhQ671csHXW7N9LdXIFGQcz4yrub03XSNlmFYuieYIPCwSTmOWYy7hfalVoQR8QI1jrHkgb79ZKoDNgeWHEfVoY+sOsVu+X7wGdY1C5hbl2OrIlITnOwCcMoEVQt9ZOUOQ+1nTKJFnWBzdcFyxrO5K2lUq2CsILXRZEZcd7YKcs1SZdM0F9GtVumSiI6HhazpAkjSaAlq8leKXjswHrBYFyYGwnOlAWkSFZeyPnf7q+BXkpiJ9NsgVfUEj8e+Z0nWCgtT/Ml4OcUuDx+BzfHN7kSRoz/IG3Ytw== me@jess.coffee"
}
