variable "COS-S3-ENDPOINT" {
  type        = string
  description = "S3-ENDPOINT of COS - https://s3.us.cloud-object-storage.appdomain.cloud for us "
  #default     = ""
}

variable "ACCESS-KEY" {
  type        = string
  description = "ACCESS-KEY of COS"
  #default     = ""
}

variable "SECRET-KEY" {
  type        = string
  description = "SECRET-KEY of COS"
  #default     = ""
}

variable "bucket-name" {
  type        = string
  description = "COS bucket-name"
  #default     = ""
}

variable "Alias" {
  type        = string
  description = "A description of my variable"
  default     = "IBMCOS"
}