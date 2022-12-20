terraform {
  backend "s3" {
    bucket = "group7acs-staging"                           // Bucket where to SAVE Terraform State
    key    = "network/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                               // Region where bucket is created
  }
}