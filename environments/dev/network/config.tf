terraform {
  backend "s3" {
    bucket = "group7dev"                   // Bucket where to SAVE Terraform State
    key    = "group7dev/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                   // Region where bucket is created
  }
}