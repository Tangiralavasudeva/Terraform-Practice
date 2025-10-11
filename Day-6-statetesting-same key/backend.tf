terraform {
  backend "s3" {
    bucket = "my-terraform-statefile-tangi"
    key    = "Day1-/terraform.tfstate"
    region = "us-east-1"
    #use_lockfile = "true"
    #dynamodb_table = "vasu-table"
    encrypt = "true"
  }
}
