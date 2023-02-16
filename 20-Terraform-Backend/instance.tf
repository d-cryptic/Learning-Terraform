terraform {
  backend "s3" {
    bucket = "barun-tf-state"
    region = "us-east-1"
    key    = "terraform.tfstate"
    dynamodb_table = "barun-practice"
  }
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "web" {
  ami           = "ami-09cd747c78a9add63"
  instance_type = "t2.micro"
}
