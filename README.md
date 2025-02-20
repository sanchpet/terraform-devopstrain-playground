## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.10.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | ~> 2.3.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_external"></a> [external](#provider\_external) | 2.3.4 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.2 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.136.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_yc-vpc"></a> [yc-vpc](#module\_yc-vpc) | git@github.com:terraform-yc-modules/terraform-yc-vpc.git | n/a |

## Resources

| Name | Type |
|------|------|
| [local_file.example](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [yandex_compute_disk.secondary-disk-first-vm](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_disk) | resource |
| [yandex_compute_instance.first-vm](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance) | resource |
| [yandex_iam_service_account.sa](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/iam_service_account) | resource |
| [yandex_iam_service_account_static_access_key.sa-static-key](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/iam_service_account_static_access_key) | resource |
| [yandex_resourcemanager_folder_iam_member.sa-editor](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/resourcemanager_folder_iam_member) | resource |
| [yandex_storage_bucket.bucket-2](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/storage_bucket) | resource |
| [external_external.example](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [terraform_remote_state.networking](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [yandex_compute_image.ubuntu-2204-latest](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/compute_image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_lifecycle_rules"></a> [bucket\_lifecycle\_rules](#input\_bucket\_lifecycle\_rules) | n/a | `list` | <pre>[<br/>  {<br/>    "expiration_days": 30,<br/>    "id": "tmp",<br/>    "prefix": "/tmp"<br/>  },<br/>  {<br/>    "expiration_days": 90,<br/>    "id": "log",<br/>    "prefix": "/log"<br/>  }<br/>]</pre> | no |
| <a name="input_disks"></a> [disks](#input\_disks) | n/a | <pre>map(object({<br/>    name = string<br/>    size = number<br/>  }))</pre> | <pre>{<br/>  "disk-1": {<br/>    "name": "disk-1",<br/>    "size": 20<br/>  },<br/>  "disk-2": {<br/>    "name": "disk-2",<br/>    "size": 10<br/>  }<br/>}</pre> | no |
| <a name="input_filename"></a> [filename](#input\_filename) | Name of file for the output | `string` | `"output.txt"` | no |
| <a name="input_first_vm_compute_resources"></a> [first\_vm\_compute\_resources](#input\_first\_vm\_compute\_resources) | First VM cpu params | <pre>map(object({<br/>    cores         = number<br/>    core_fraction = number<br/>    memory        = number<br/>  }))</pre> | n/a | yes |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Yandex cloud folder ID | `string` | n/a | yes |
| <a name="input_instances"></a> [instances](#input\_instances) | n/a | <pre>map(object({<br/>    name = string<br/>    disk = string<br/>  }))</pre> | <pre>{<br/>  "vm-1": {<br/>    "disk": "disk-1",<br/>    "name": "instance-1"<br/>  },<br/>  "vm-2": {<br/>    "disk": "disk-2",<br/>    "name": "instance-2"<br/>  }<br/>}</pre> | no |
| <a name="input_second_bucket"></a> [second\_bucket](#input\_second\_bucket) | Bucket to test import | `string` | n/a | yes |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | Service account | `string` | n/a | yes |
| <a name="input_state_bucket"></a> [state\_bucket](#input\_state\_bucket) | Bucket for terraform state | `string` | n/a | yes |
| <a name="input_subnet_params"></a> [subnet\_params](#input\_subnet\_params) | VPC subnet params | <pre>object({<br/>    zone = string<br/>    cidr = list(string)<br/>  })</pre> | <pre>{<br/>  "cidr": [<br/>    "10.5.0.0/24"<br/>  ],<br/>  "zone": "ru-central1-a"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_file_contents"></a> [file\_contents](#output\_file\_contents) | Prints file content |
