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

variable "sharp_server_memory" {
  type        = number
  default     = 2048
  description = "Lambda sharp server memory"
}

variable "sharp_server_cache_ttl" {
  type = number
  default = 31536000
  description = "Cache ttl for images"
}