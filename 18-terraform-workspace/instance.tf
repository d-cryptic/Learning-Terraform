data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = [""]

  filter {
    name   = "name"
    values = ["${var.image_name}"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#output "keyname" {
#  value = aws_key_pair.key-tf.key_name
#}

#creating instance
resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = "firsttestec2"
  }
  user_data = file("${path.module}/script.sh")


  #global for all provisioners
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/aws")
    host        = self.public_ip
  }


  provisioner "file" {
    source      = "../README.md"   #terraform machine
    destination = "/tmp/README.md" #remote machine
  }

  provisioner "file" {
    content     = "this is test content"
    destination = "/tmp/content.md"
  }

  provisioner "local-exec" {
    on_failure = continue
    command    = "env>env.txt"
    environment = {
      envname = "envvalue"
    }
  }

  provisioner "local-exec" {
    # command = "echo ${self.public_ip} > /tmp/mypublicip.txt"
    command = "echo 'at create'"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'at delete'"
  }

  provisioner "local-exec" {
    working_dir = "/tmp/"
    command     = "echo ${self.public_ip} > mypublicip.txt"
  }

  provisioner "local-exec" {
    interpreter = [
      "/usr/bin/python3", "-c"
    ]
    command = "print('HelloWorld')"
  }

  provisioner "remote-exec" {
    inline = [
      "ifconfig > /tmp/ifconfig.output",
      "echo 'hello barun' > /tmp/test.txt"
    ]
  }

  #path to script file
  provisioner "remote-exec" {
    # when = destroy
    script = "./testscript.sh"
  }

}
