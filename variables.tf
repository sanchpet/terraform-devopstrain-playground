variable "filename" {
  description = "Name of file for the output"
  type        = string
  default     = "output.txt"
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
    zone = string
    cidr = list(string)
  })

  default = {
    zone = "ru-central1-a"
    cidr = ["10.5.0.0/24"]
  }
}

variable "first_vm_compute_resources" {
  description = "First VM cpu params"
  type = map(object({
    cores         = number
    core_fraction = number
    memory        = number
  }))

  validation {
    condition = alltrue([
      for config in var.first_vm_compute_resources :
      config.core_fraction < 60
    ])
    error_message = "We don't want to pay for such powerful machine"
  }
}

variable "instances" {
  type = map(object({
    name = string
    disk = string
  }))
  default = {
    vm-1 = {
      name = "instance-1"
      disk = "disk-1"
    }
    vm-2 = {
      name = "instance-2"
      disk = "disk-2"
    }
  }
}

variable "disks" {
  type = map(object({
    name = string
    size = number
  }))
  default = {
    disk-1 = {
      name = "disk-1"
      size = 20
    }
    disk-2 = {
      name = "disk-2"
      size = 10
    }
  }
}

variable "bucket_lifecycle_rules" {
  default = [
    {
      id              = "tmp",
      prefix          = "/tmp"
      expiration_days = 30
    },
    {
      id              = "log",
      prefix          = "/log"
      expiration_days = 90
    }
  ]
}
