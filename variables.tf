variable "filename" {
  description = "Name of file for the output"
  type        = string
  default = "output.txt"
}

variable "folder_id" {
  description = "Yandex cloud folder ID"
  type        = string
}

// Новые переменные:
variable "service_account" {
  description = "Service account"
  type        = string
}

variable "state_bucket" {
  description = "Bucket for terraform state"
  type        = string
}

variable "second_bucket" {
  description = "Bucket to test import"
  type        = string
}

variable "subnet_params" {
  description = "VPC subnet params"
    type = object({
      zone    = string
      cidr = list(string)
  })

  default = {
    zone = "ru-central1-a"
    cidr = ["10.5.0.0/24"]
  }
}

variable "first_vm_compute_resources" {
  description = "First VM cpu params"
    type = object({
      cores  = number
      core_fraction = number
      memory = number
    })

  validation {
    condition     = var.core_fraction < 60
    error_message = "We don't want to pay for such powerful machine"
  }
}
