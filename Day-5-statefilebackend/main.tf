resource "aws_instance" "web01" {
  ami           = "ami-052064a798f08f0d3"
  instance_type = "t2.micro"
    tags = {
        Name = "web01"
    }

}

resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my_vpc"
    }
  
}