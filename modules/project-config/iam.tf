resource "aws_iam_role" "terraform-deploy-role" {
  name = "TerraformDeployRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "terraform-deploy-kms-policy" {
  name = "TerraformDeployKMSPolicy"
  role = aws_iam_role.terraform-deploy-role.id

  policy = <<EOF
{
  "Id": "terraform-deploy-role",
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "AllowAccessForKeyAdministrators",
          "Effect": "Allow",
          "Action": [
              "kms:Create*",
              "kms:Describe*",
              "kms:Enable*",
              "kms:List*",
              "kms:Put*",
              "kms:Update*",
              "kms:Revoke*",
              "kms:Disable*",
              "kms:Get*",
              "kms:Delete*",
              "kms:TagResource",
              "kms:UntagResource",
              "kms:ScheduleKeyDeletion",
              "kms:CancelKeyDeletion"
          ],
          "Resource": "*"
      },
      {
          "Sid": "AllowUseOfTheKey",
          "Effect": "Allow",
          "Action": [
              "kms:Encrypt",
              "kms:Decrypt",
              "kms:ReEncrypt*",
              "kms:GenerateDataKey*",
              "kms:DescribeKey"
          ],
          "Resource": "*"
      },
      {
          "Sid": "AllowAttachmentOfPersistentResources",
          "Effect": "Allow",
          "Action": [
              "kms:CreateGrant",
              "kms:ListGrants",
              "kms:RevokeGrant"
          ],
          "Resource": "*",
          "Condition": {
              "Bool": {
                  "kms:GrantIsForAWSResource": "true"
              }
          }
      }
  ]
}
EOF
}