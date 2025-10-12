module "prod" {
    source = "github.com/Tangiralavasudeva/Terraform-Practice/Day-9-modules"
    ami_id = "ami-05ffe3c48a9991133"
    instance_type = "t2.micro"
    #key = "test"
    az = "us-east-1a"
}