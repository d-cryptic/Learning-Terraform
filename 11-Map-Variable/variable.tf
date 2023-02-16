variable "usersage" {
  type = map
  default = {
    barun = 20
    saurav = 19
  }
}

output "userage" {
  value = "My name is gaurav and my age is ${lookup(var.usersage, "barun")}"
}
