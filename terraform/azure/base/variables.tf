variable "prefix" {
  description = "Will be prefixed to all resource names. Use to easily identify the resources created"
  type        = string
}

variable "location" {
  description = "The location in which all resources will be created (e.g. australiaeast)"
  type        = string
}

variable "tags" {
  description = "The tags to append to the resources in this module"
  default     = {}
  type        = map(string)
}
