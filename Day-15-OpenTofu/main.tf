resource "aws_instance" "name" {
    ami = "ami-085ad6ae776d8f09c"
    instance_type = "t2.micro"
    #key_name = "ec2test"
    availability_zone = "us-east-1a"
    tags = {
      Name = "dev"
    }
   
    user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y httpd
                sudo systemctl start httpd
                sudo systemctl enable httpd
                echo "<h1>Welcome to Dev Environment</h1>" > /var/www/html/index.html
                EOF
}