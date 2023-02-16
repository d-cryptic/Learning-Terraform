variable "usersage" {
  type = map
  default = {
    barun = 20
    saurav = 19
  }
}

variable "username" {
  type = string
}

output "userage" {
  value = "My name is ${var.username} and my age is ${lookup(var.usersage, "${var.username}")}"
}
