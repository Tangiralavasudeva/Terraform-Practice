resource "aws_instance" "my_web01" {
    ami = var.ami_id
    instance_type = var.instance_type

    tags = {
        Name = "my_web01"
    }
  
}

resource "aws_instance" "my_web02" {
    ami = var.ami_id
    instance_type = var.instance_type

    tags = {
        Name = "my_web02"
    }
  
}