variable age {
  type = number
}

variable "username" {
  type = string
}

output printname {
  value = "Hello, ${var.username}, your age in ${var.age}" 
}
