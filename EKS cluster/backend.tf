terraform {
  backend "s3" {
    bucket = "trrraform-buckett-locking"
    key    = "EKS/terraform.tfstate"
    region = "ca-central-1"
  }
}
