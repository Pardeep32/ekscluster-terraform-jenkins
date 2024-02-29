terraform {
  backend "s3" {
    bucket = "trrraform-buckett-locking"
    key    = "network/terraform.tfstate"
    region = "ca-central-1"
  }
}
