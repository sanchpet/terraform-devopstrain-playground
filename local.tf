data "external" "example" {
  program = ["echo", "{\"name\": \"somename\", \"desc\": \"somedesc\"}"]

}

resource "local_file" "example" {
  filename = "output-${terraform.workspace}.txt"
  content = templatefile("templates/template.tpl", {
    key1 = data.external.example.result.name
    key2 = data.external.example.result.desc
  })
}
