
variable "group_name" {
  description = "The name of the IAM group."
}

variable "member_object_ids" {
  description = "A list of object IDs for the members of the IAM group."
  type        = list(string)
  default     = []
}