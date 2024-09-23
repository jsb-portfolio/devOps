data "aws_availability_zones" "available" {}

locals {
  name = "workspace-${basename(path.cwd)}"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.name
  cidr = local.vpc_cidr

  azs              = local.azs
  private_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 3)]
  database_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 6)]

  enable_nat_gateway = false

  # enable_ipv6                   = true
  # private_subnet_ipv6_prefixes  = [0, 1, 2]
  # public_subnet_ipv6_prefixes   = [3, 4, 5]
  # database_subnet_ipv6_prefixes = [6, 7, 8]

  create_database_subnet_group = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
