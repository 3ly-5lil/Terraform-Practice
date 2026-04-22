variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "The AWS region to deploy resources in"
}

variable "ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "The type of EC2 instance to create"
  validation {
    condition = contains(
      ["t2.micro", "t3.micro"],
      var.ec2_instance_type
    )

    error_message = "the instance must be either t2 or t3 micro"
  }
}

variable "ec2_volume_config" {
  type = object({
    size = number
    type = string
  })
  default = {
    size = 8
    type = "gp3"
  }
  description = "The configuration for the EC2 instance's root block device"

}

variable "additional_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to resources"
}
