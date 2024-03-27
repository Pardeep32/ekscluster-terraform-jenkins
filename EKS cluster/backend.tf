terraform {
  backend "s3" {
    bucket = "redditbucketclone1708"
    key    = "EKScluster/terraform.tfstate"
    region = "ca-central-1"
  }
}
