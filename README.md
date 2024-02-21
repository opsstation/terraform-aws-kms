# Terraform-aws-kms

# Terraform AWS Cloud KMS Module

## Table of Contents
- [Introduction](#introduction)
- [Usage](#usage)
- [Examples](#Examples)
- [Author](#Author)
- [License](#license)
- [Inputs](#inputs)
- [Outputs](#outputs)

## Introduction
This Terraform module creates an AWS Key Management Service (KMS) along with additional configuration options.
## Usage
To use this module, you should have Terraform installed and configured for AWS. This module provides the necessary Terraform configuration for creating AWS resources, and you can customize the inputs as needed. Below is an example of how to use this module:
## Examples

## Example: Default

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

## Examples
For detailed examples on how to use this module, please refer to the [Examples](https://github.com/opsstation/terraform-aws-kms/tree/master/example) directory within this repository.

## Author
Your Name Replace **MIT** and **opsstation** with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

## License
This project is licensed under the **MIT** License - see the [LICENSE](https://github.com/opsstation/terraform-aws-kms/blob/master/LICENSE) file for details.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | git::https://github.com/opsstation/terraform-aws-labels.git | v1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_external_key.external](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_external_key) | resource |
| [aws_kms_key.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_replica_external_key.replica_external](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_replica_external_key) | resource |
| [aws_kms_replica_key.replica](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_replica_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alias"></a> [alias](#input\_alias) | The display name of the alias. The name must start with the word `alias` followed by a forward slash. | `string` | `""` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes (e.g. `1`). | `list(string)` | `[]` | no |
| <a name="input_bypass_policy_lockout_safety_check"></a> [bypass\_policy\_lockout\_safety\_check](#input\_bypass\_policy\_lockout\_safety\_check) | A flag to indicate whether to bypass the key policy lockout safety check. Setting this value to true increases the risk that the KMS key becomes unmanageable | `bool` | `false` | no |
| <a name="input_create_external_enabled"></a> [create\_external\_enabled](#input\_create\_external\_enabled) | Determines whether an external CMK (externally provided material) will be created or a standard CMK (AWS provided material) | `bool` | `false` | no |
| <a name="input_create_replica_enabled"></a> [create\_replica\_enabled](#input\_create\_replica\_enabled) | Determines whether a replica standard CMK will be created (AWS provided material) | `bool` | `false` | no |
| <a name="input_create_replica_external_enabled"></a> [create\_replica\_external\_enabled](#input\_create\_replica\_external\_enabled) | Determines whether a replica external CMK will be created (externally provided material) | `bool` | `false` | no |
| <a name="input_customer_master_key_spec"></a> [customer\_master\_key\_spec](#input\_customer\_master\_key\_spec) | Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC\_DEFAULT, RSA\_2048, RSA\_3072, RSA\_4096, ECC\_NIST\_P256, ECC\_NIST\_P384, ECC\_NIST\_P521, or ECC\_SECG\_P256K1. Defaults to SYMMETRIC\_DEFAULT. | `string` | `"SYMMETRIC_DEFAULT"` | no |
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | Duration in days after which the key is deleted after destruction of the resource. | `number` | `10` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the key as viewed in AWS console. | `string` | `"Parameter Store KMS master key"` | no |
| <a name="input_enable_key_rotation"></a> [enable\_key\_rotation](#input\_enable\_key\_rotation) | Specifies whether key rotation is enabled. | `string` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Specifies whether the kms is enabled or disabled. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Specifies whether the key is enabled. | `bool` | `true` | no |
| <a name="input_key_material_base64"></a> [key\_material\_base64](#input\_key\_material\_base64) | Base64 encoded 256-bit symmetric encryption key material to import. The CMK is permanently associated with this key material. External key only | `string` | `null` | no |
| <a name="input_key_usage"></a> [key\_usage](#input\_key\_usage) | Specifies the intended use of the key. Defaults to ENCRYPT\_DECRYPT, and only symmetric encryption and decryption are supported. | `string` | `"ENCRYPT_DECRYPT"` | no |
| <a name="input_kms_key_enabled"></a> [kms\_key\_enabled](#input\_kms\_key\_enabled) | Specifies whether the kms is enabled or disabled. | `bool` | `true` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| <a name="input_managedby"></a> [managedby](#input\_managedby) | n/a | `string` | `""` | no |
| <a name="input_multi_region"></a> [multi\_region](#input\_multi\_region) | Indicates whether the KMS key is a multi-Region (true) or regional (false) key. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | A valid policy JSON document. Although this is a key policy, not an IAM policy, an `aws_iam_policy_document`, in the form that designates a principal, can be used | `string` | `null` | no |
| <a name="input_primary_external_key_arn"></a> [primary\_external\_key\_arn](#input\_primary\_external\_key\_arn) | The primary external key arn of a multi-region replica external key | `string` | `null` | no |
| <a name="input_primary_key_arn"></a> [primary\_key\_arn](#input\_primary\_key\_arn) | The primary key arn of a multi-region replica key | `string` | `""` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Terraform current module repo | `string` | `""` | no |
| <a name="input_valid_to"></a> [valid\_to](#input\_valid\_to) | Time at which the imported key material expires. When the key material expires, AWS KMS deletes the key material and the CMK becomes unusable. If not specified, key material does not expire | `string` | `"2024-01-02T15:04:05Z"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alias_arn"></a> [alias\_arn](#output\_alias\_arn) | Alias ARN. |
| <a name="output_alias_name"></a> [alias\_name](#output\_alias\_name) | Alias name. |
| <a name="output_key_arn"></a> [key\_arn](#output\_key\_arn) | Key ARN. |
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | Key ID. |
| <a name="output_tags"></a> [tags](#output\_tags) | A mapping of tags to assign to the resource. |
| <a name="output_target_key_id"></a> [target\_key\_id](#output\_target\_key\_id) | Identifier for the key for which the alias is for, can be either an ARN or key\_id. |
<!-- END_TF_DOCS -->