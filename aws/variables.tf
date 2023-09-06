variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
}

variable "aws_region" {
  description = "The AWS region where the resources should be deployed"
  type        = string

  validation {
    condition     = var.aws_region != null
    error_message = "The variable 'aws_region' must be provided."
  }

  validation {
    condition = (
      contains(
        ["eu-central-1", "eu-west-1", "us-west-2"],
        var.aws_region,
      )
    )
    error_message = "The variable 'aws_region' must be one of \n ${join("", [for value in ["eu-central-1", "eu-west-1", "us-west-2"] : "\n- ${value}"])}."
  }
}

