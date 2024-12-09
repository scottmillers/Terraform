
module "subnet" {
  source = "../../../modules/subnet"
  region = var.region
  profile = "sandbox"
  environment = "dev"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  cidr_block = "10.0.0.0/19"
}