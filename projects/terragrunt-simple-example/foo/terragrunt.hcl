# foo/terragrunt.hcl
terraform {
  source = "../shared"
}

inputs = {
  content = "Hello from foo, Terragrunt!"
}
