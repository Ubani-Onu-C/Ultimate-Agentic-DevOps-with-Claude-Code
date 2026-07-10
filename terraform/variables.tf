variable "region" {
  description = "AWS region to deploy resources into."
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name, used for resource naming and tagging."
  type        = string
  default     = "portfolio-site"
}

variable "environment" {
  description = "Deployment environment (e.g. production, staging)."
  type        = string
  default     = "production"
}

variable "domain_name" {
  description = "Optional custom domain name for the CloudFront distribution. Leave empty to use the default *.cloudfront.net domain."
  type        = string
  default     = ""
}
