variable "subnet_configs" {
  type = map(object({
    cidr : string,
  }))

  description = "A map of subnet configurations, where the key is a unique identifier for each subnet and the value is an object containing the CIDR block for that subnet"

  validation {
    condition = alltrue([
      for config in values(var.subnet_configs) :
      can(cidrnetmask(config.cidr))
    ])
    error_message = "At least one of the provided CIDR blocks is not valid."

  }
}

variable "ec2_instance_configs" {
  type = list(object({
    ami           = string
    instance_type = string
  }))

  default = []

  validation {
    condition     = alltrue([for config in var.ec2_instance_configs : config.instance_type == "t2.micro"])
    error_message = "Only t2.micro instance type is allowed for this demo"
  }

  validation {
    condition = alltrue([
      for config in var.ec2_instance_configs :
      config.ami == "ubuntu" || config.ami == "windows_sql_server"
    ])
    error_message = "Invalid AMI value. Please choose either 'ubuntu' or 'windows_sql_server'"
  }
}


variable "ec2_instance_configs_map" {
  type = map(object({
    ami           = string
    instance_type = string
    subnet_name   = optional(string, "default")
  }))

  default = {}

  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_configs_map) :
      config.instance_type == "t2.micro"
    ])
    error_message = "Only t2.micro instance type is allowed for this demo"
  }

  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_configs_map) :
      contains(["ubuntu", "windows_sql_server"], config.ami)
    ])
    error_message = "Invalid AMI value. Please choose either 'ubuntu' or 'windows_sql_server'"
  }
}
