terraform {
  backend "s3" {
    bucket = "terrraform-buckett-locking"
    key    = "EKS/terraform.tfstate"
    region = "ca-central-1"
  }
}
