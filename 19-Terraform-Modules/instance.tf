module "webserver" {
  source        = "./modules/webserver"
  image_id      = var.image_id
  instance_type = var.instance_type
  key           = file("${path.module}/aws.pub")
  key_name      = var.key_name
}

output "publicIp" {
  # value = aws_instance.web.public_id
  value = module.webserver.publicIp
}
