terraform {
  backend "s3" {
    bucket = "aws1bucketone"
    key    = "fault/terraform.tfstate"
    region = "eu-west-2"
  }

}