module "yc-vpc" {
  source              = "git@github.com:terraform-yc-modules/terraform-yc-vpc.git"
  network_name        = "main"
  network_description = "Test network created with module"
  private_subnets = [{
    name           = "subnet-1"
    zone           = "ru-central1-a"
    v4_cidr_blocks = ["10.5.0.0/24"]
    }
  ]
}
