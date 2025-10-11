terraform {
  backend "s3" {
    bucket = "my-terraform-statefile-tangi"
    key    = "terraform.tfstate"
    region = "us-east-1"
    use_lockfile = "true"
    encrypt = "true"
  }
}
