locals {
  region        = "us-east-1"
  instance_type = "t2.micro"
}

resource "aws_instance" "example" {
  ami           = "ami-07860a2d7eb515d9a"
  instance_type = local.instance_type
  tags = {
    Name = "App-${local.region}"
  }
}