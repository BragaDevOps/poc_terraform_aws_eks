resource "aws_kms_key" "default" {
  description             = var.AWS_KMS_DESCRIPTION
  deletion_window_in_days = 7

  policy = <<EOF
{
    "Id":"terraform-deploy-role",
    "Version":"2012-10-17",
    "Statement":[
      {
          "Sid":"EnableIAMUserPermissions",
          "Effect":"Allow",
          "Principal":{
            "AWS":"arn:aws:iam::${var.AWS_ACCOUNT_ID}:root"
          },
          "Action":"kms:*",
          "Resource":"*"
      },
      {
          "Sid":"AllowAccessForKeyAdministrators",
          "Effect":"Allow",
          "Principal":{
            "AWS":"arn:aws:iam::${var.AWS_ACCOUNT_ID}:user/${var.AWS_USER_DEPLOY}"
          },
          "Action":[
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
          "Resource":"*"
      },
      {
          "Sid":"AllowUseOfTheKey",
          "Effect":"Allow",
          "Principal":{
            "AWS":"arn:aws:iam::${var.AWS_ACCOUNT_ID}:user/${var.AWS_USER_DEPLOY}"
          },
          "Action":[
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:DescribeKey"
          ],
          "Resource":"*"
      },
      {
          "Sid":"AllowAttachmentOfPersistentResources",
          "Effect":"Allow",
          "Principal":{
            "AWS":"arn:aws:iam::${var.AWS_ACCOUNT_ID}:user/${var.AWS_USER_DEPLOY}"
          },
          "Action":[
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:RevokeGrant"
          ],
          "Resource":"*",
          "Condition":{
            "Bool":{
                "kms:GrantIsForAWSResource":"true"
            }
          }
      }
    ]
}
EOF

}

resource "aws_kms_alias" "kms" {
  name = format("alias/%s", var.AWS_KMS_DESCRIPTION)
  target_key_id = aws_kms_key.default.key_id
}