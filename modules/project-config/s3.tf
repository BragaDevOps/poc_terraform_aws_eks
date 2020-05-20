resource "aws_s3_bucket" "terraform-backend" {
  bucket        = "${var.AWS_S3_TERRAFORM_BACKEND}.${var.AWS_REGION}.${var.AWS_ACCOUNT_ID}"
  acl           = "private"
  force_destroy = false

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.default.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = {
    Environment = "${var.ENVIRONMENT}"
  }
}

resource "aws_s3_bucket_public_access_block" "terraform-backend-acl" {
  bucket = aws_s3_bucket.terraform-backend.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_iam_role_policy" "terraform-backend-s3-policy" {
  name = "TerraformDeployS3Policy"
  role = aws_iam_role.terraform-deploy-role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetObject", 
        "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::${var.AWS_S3_TERRAFORM_BACKEND}.${var.AWS_REGION}.${var.AWS_ACCOUNT_ID}/*"
    }
  ]
}
EOF
}