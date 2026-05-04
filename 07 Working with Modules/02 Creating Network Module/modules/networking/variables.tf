variable "vpc_configs" {
  type = object({
    cidr = string
    name = string
  })
  default = {
    cidr = "10.0.0.0/16"
    name = "VPC from Module"
  }
  description = "Configuration for the VPC"

  validation {
    condition     = can(cidrnetmask(var.vpc_configs.cidr))
    error_message = "Invalid CIDR block for VPC. Please provide a valid CIDR block, (e.g., 10.0.0.0/16)."
  }
}

variable "subnet_config" {
  type = map(object({
    az         = string
    cidr_block = string
    public     = optional(bool, false)
  }))

  validation {
    condition = alltrue([
      for config in values(var.subnet_config) :
      can(cidrnetmask(config.cidr_block))
    ])

    error_message = "At least one of the provided CIDR blocks for subnets is invalid. Please provide valid CIDR blocks"
  }
}
