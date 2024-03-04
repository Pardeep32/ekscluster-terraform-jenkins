terraform {
  backend "s3" {
    bucket = "terrraform-buckett-locking"
    key    = "netwok/terraform.tfstate"
    region = "ca-central-1"
  }
}
