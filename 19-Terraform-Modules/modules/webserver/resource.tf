# key
resource "aws_key_pair" "key-tf" {
  key_name   = "key-tf"
  public_key = var.key
}

#instance
resource "aws_instance" "web" {
  ami           = var.image_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.key-tf.key_name
}
