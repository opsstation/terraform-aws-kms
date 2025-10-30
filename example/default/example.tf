provider "aws" {
  region = "eu-west-1"
}

# --- Data sources ---
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

# --- Default KMS Policy ---
data "aws_iam_policy_document" "default" {
  version = "2012-10-17"

  statement {
    sid    = "EnableIAMUserPermissions"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        format("arn:%s:iam::%s:root",
          data.aws_partition.current.partition,
          data.aws_caller_identity.current.account_id
        )
      ]
    }

    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowCloudTrailToEncryptLogs"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["kms:GenerateDataKey*"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values = [
        "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"
      ]
    }
  }

  statement {
    sid    = "AllowCloudTrailToDescribeKey"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["kms:DescribeKey"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowPrincipalsInTheAccountToDecryptLogFiles"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        format("arn:%s:iam::%s:root",
          data.aws_partition.current.partition,
          data.aws_caller_identity.current.account_id
        )
      ]
    }

    actions = [
      "kms:Decrypt",
      "kms:ReEncryptFrom"
    ]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }

    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values = [
        "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"
      ]
    }
  }

  statement {
    sid    = "AllowAliasCreationDuringSetup"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        format("arn:%s:iam::%s:root",
          data.aws_partition.current.partition,
          data.aws_caller_identity.current.account_id
        )
      ]
    }

    actions   = ["kms:CreateAlias"]
    resources = ["*"]
  }
}

# --- KMS Module ---
module "kms_key" {
  source                  = "./../../"
  name                    = "kms"
  environment             = "test"
  deletion_window_in_days = 7
  alias                   = "alias/cloudtrail_Name"
  kms_key_enabled         = true
  multi_region            = true
  valid_to                = "2023-11-21T23:20:50Z"
  primary_key_arn         = "arn:aws:kms:us-east-1:123456789012:key/abcd1234-56ef-78gh-90ij-klmnopqrstuv"
  custom_policy           = fileexists("${path.module}/custom_policy.json") ? file("${path.module}/custom_policy.json") : null
  policy                  = data.aws_iam_policy_document.default.json
  aws_principal_arn       = "arn:aws:iam::123456789012:root"
}
