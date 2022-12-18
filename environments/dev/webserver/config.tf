terraform {
  backend "s3" {
    bucket = "group7acs-dev"                             // Bucket where to SAVE Terraform State
    key    = "group7acs-dev/webserver/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                                 // Region where bucket is created
  }
}