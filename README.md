# 🏗️ Terraform-AWS-Kms

[![OpsStation](https://img.shields.io/badge/Made%20by-OpsStation-blue?style=flat-square&logo=terraform)](https://www.opsstation.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Terraform](https://img.shields.io/badge/Terraform-1.13%2B-purple.svg?logo=terraform)](#)
[![CI](https://github.com/OpsStation/terraform-aws-kms/actions/workflows/ci.yml/badge.svg)](https://github.com/OpsStation/terraform-aws-kms/actions/workflows/ci.yml)

> 🌩️ **A production-grade, reusable AWS Kms module by [OpsStation](https://www.opsstation.com)**
> Designed for reliability, performance, and security — following AWS networking best practices.
---

## 🏢 About OpsStation

**OpsStation** delivers **Cloud & DevOps excellence** for modern teams:
- 🚀 **Infrastructure Automation** with Terraform, Ansible & Kubernetes
- 💰 **Cost Optimization** via scaling & right-sizing
- 🛡️ **Security & Compliance** baked into CI/CD pipelines
- ⚙️ **Fully Managed Operations** across AWS, Azure, and GCP

> 💡 Need enterprise-grade DevOps automation?
> 👉 Visit [**www.opsstation.com**](https://www.opsstation.com) or email **hello@opsstation.com**

---

## 🌟 Features

- ✅ Creates and manages **AWS KMS Keys** and **Aliases**
- ✅ Supports **symmetric** and **asymmetric** encryption keys
- ✅ Optional **automatic key rotation** for enhanced security
- ✅ Configurable **key policies** and **grants** for fine-grained access control
- ✅ Seamless integration with **AWS services** (e.g., S3, EBS, RDS, Lambda)
- ✅ Supports **multi-region keys** for high availability and disaster recovery
- ✅ Compatible with **CloudTrail** for detailed key usage logging
- ✅ Tags and naming convention managed through the **Labels module**
- ✅ Seamless integration with other **OpsStation Terraform modules**

---

## ⚙️ Usage Example

```hcl
module "kms_key" {
  source                  = "git::https://github.com/opsstation/terraform-aws-kms.git?ref=v1.0.0"
  name                    = "kms"
  environment             = "test"
  deletion_window_in_days = 7
  alias                   = "alias/cloudtrail_Name"
  kms_key_enabled         = true
  multi_region            = true
  valid_to                = "2023-11-21T23:20:50Z"
  policy                  = data.aws_iam_policy_document.default.json
}
```

## Example: kms-key-external
```hcl
module "kms_key" {
  source                  = "git::https://github.com/opsstation/terraform-aws-kms.git?ref=v1.0.0"
  name                    = "kms"
  environment             = "test"
  deletion_window_in_days = 7
  alias                   = "alias/external_key"
  kms_key_enabled         = false
  enabled                 = true
  multi_region            = true
  create_external_enabled = true
  valid_to                = "2023-11-21T23:20:50Z"
  key_material_base64     = "WblXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  policy                  = data.aws_iam_policy_document.default.json
}
```

## Example: kms-key-replica

```hcl
module "kms_key" {
  source                  = "git::https://github.com/opsstation/terraform-aws-kms.git?ref=v1.0.0"
  name                    = "kms"
  environment             = "test"
  deletion_window_in_days = 7
  alias                   = "alias/replicate_key"
  kms_key_enabled         = false
  create_replica_enabled  = true
  enabled                 = true
  multi_region            = false
  primary_key_arn         = "arn:aws:kms:us:key/XXXXXXXXXXXXXXXXXXXXXX"
  policy                  = data.aws_iam_policy_document.default.json
}
```
### 🔐 Outputs (AWS KMS Module)

| Name                 | Description                                                                 |
|----------------------|-----------------------------------------------------------------------------|
| `key_id`             | The unique identifier of the created **KMS Key**.                           |
| `key_arn`            | The ARN (Amazon Resource Name) of the created **KMS Key**.                  |
| `alias_name`         | The name of the created **KMS Alias**.                                      |
| `alias_arn`          | The ARN of the created **KMS Alias**.                                       |
| `key_policy`         | The **IAM policy document** attached to the KMS key.                        |
| `key_state`          | The current **status/state** of the KMS key (e.g., Enabled, Disabled).      |
| `key_rotation_status`| Indicates whether **automatic key rotation** is enabled.                    |
| `key_usage`          | Specifies the **intended use** of the KMS key (e.g., ENCRYPT_DECRYPT).      |
| `multi_region`       | Indicates if the KMS key is a **Multi-Region Key**.                         |
| `tags`               | A mapping of **tags** assigned to the KMS resources.                        |


### ☁️ Tag Normalization Rules (AWS)

| Cloud | Case      | Allowed Characters | Example                            |
|--------|-----------|------------------|------------------------------------|
| **AWS** | TitleCase | Any              | `Name`, `Environment`, `CostCenter` |

---

### 💙 Maintained by [OpsStation](https://www.opsstation.com)
> OpsStation — Simplifying Cloud, Securing Scale.
