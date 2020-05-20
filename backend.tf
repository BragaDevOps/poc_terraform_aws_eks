terraform {
  backend "s3" {
    bucket  = "terraform-projects.us-east-1.379851106041"
    key     = "self/terraform.tfstate"
    region  = "us-east-1"
    profile = "brg"
  }
}
