variable "name" {
  type        = string
  description = "Name prefix for resources on AWS"
  default     = "sharp-server"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Default resource tags"
}

variable "sharp_server_version" {
  description = "Sharp Server version"
  type        = string
  default     = "0.1.0"
}

variable "log_level" {
  default       = "warn"
  type          = string
  description   = "Log level"
  validation {
    condition     = length(regexall("^(debug|info|warn|error)$", var.log_level)) > 0
    error_message = "ERROR: Valid types are \"debug\", \"info\", \"warn\" and \"error\"!"
  }
}

variable "memory" {
  type        = number
  default     = 2048
  description = "Lambda sharp server memory"
}

variable "cache_ttl" {
  type        = number
  default     = 31536000
  description = "Cache ttl for images"
}

variable "wait_for_deployment" {
  type        = bool
  default     = false
  description = "Wait for deployment"
}

variable "cloudfront_price_class" {
  default     = "PriceClass_200"
  type        = string
  description = "Cloudfront price class"
}

variable "custom_domain_name" {
  default     = null
  type        = string
  description = "Custom domain name"
}

variable "custom_certificate_arn" {
  default     = null
  type        = string
  description = "Custom certificate arn"
}

variable "custom_certificate_protocol_version" {
  default     = "TLSv1.2_2021"
  type        = string
  description = "Certificate protocol version"
}
