# Sharp Server Terraform Module for AWS #

This Terraform module creates the infrastructure on AWS for [Sharp Server](https://github.com/Sharp-Server/sharp-server).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_deployment.sharp_server_gw_deployment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment) | resource |
| [aws_api_gateway_integration.sharp_server_proxy_integration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_integration.sharp_server_root_integration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_method.sharp_server_proxy_method](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_method.sharp_server_root_method](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_resource.sharp_server_proxy_resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_resource) | resource |
| [aws_api_gateway_rest_api.sharp_server_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api) | resource |
| [aws_cloudfront_distribution.sharp_server_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_iam_role.api_lambda_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.AWSLambdaVPCAccessExecutionRole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.sharp_server_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.lambda_permission](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_iam_policy_document.api_lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name prefix for resources on AWS | `string` | `"sharp-server"` | no |
| <a name="input_sharp_server_cache_ttl"></a> [sharp\_server\_cache\_ttl](#input\_sharp\_server\_cache\_ttl) | Cache ttl for images | `number` | `31536000` | no |
| <a name="input_sharp_server_memory"></a> [sharp\_server\_memory](#input\_sharp\_server\_memory) | Lambda sharp server memory | `number` | `2048` | no |
| <a name="input_sharp_server_version"></a> [sharp\_server\_version](#input\_sharp\_server\_version) | Sharp Server version | `string` | `"0.1.0"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Default resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sharp_server_api_gateway_url"></a> [sharp\_server\_api\_gateway\_url](#output\_sharp\_server\_api\_gateway\_url) | The URL of the sharp server api gateway |
| <a name="output_sharp_server_cloudfront_url"></a> [sharp\_server\_cloudfront\_url](#output\_sharp\_server\_cloudfront\_url) | The URL of the sharp server cloudfront |
<!-- END_TF_DOCS -->