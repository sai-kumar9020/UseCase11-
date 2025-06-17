terraform {
  backend "s3" {
    bucket = "hcltrainings"
    key    = "uc-11/terraform.tfstate"
    region = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}