resource "random_id" "rand_id" {
  byte_length = 8
}

locals {
  db_name = "free-tier-postgres-${random_id.rand_id.hex}"
}

module "postgres" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.9.0"

  identifier               = local.db_name
  engine                   = "postgres"
  engine_version           = "16.3" # Version should be free-tier eligible
  family                   = "postgres16"
  major_engine_version     = "16"
  engine_lifecycle_support = "open-source-rds-extended-support-disabled"

  instance_class    = "db.t4g.micro" # Free tier eligible instance type
  storage_type      = "gp3"
  allocated_storage = 20 # Free tier allows up to 20 GB

  db_subnet_group_name   = module.vpc.database_subnet_group
  vpc_security_group_ids = [module.security_group_postgres.security_group_id]

  multi_az                = false # Multi-AZ deployments are not free-tier eligible
  skip_final_snapshot     = true
  deletion_protection     = false
  backup_retention_period = 1

  username                             = "postgres"
  manage_master_user_password_rotation = false

  performance_insights_enabled = false

  tags = {
    Environment = "dev"
    Name        = local.db_name
  }

  depends_on = [module.vpc]
}

module "security_group_postgres" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = local.db_name
  description = "Complete PostgreSQL example security group"
  vpc_id      = module.vpc.vpc_id

  # Ingress rules: Allow incoming IPv4 connections
  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "PostgreSQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    }
  ]

  # # Egress rules: Allow outgoing IPv6 connections only
  # egress_with_ipv6_cidr_blocks = [
  #   {
  #     from_port        = 0
  #     to_port          = 0
  #     protocol         = "-1" # Allow all protocols
  #     description      = "Allow all outgoing IPv6 traffic"
  #     ipv6_cidr_blocks = "::/0" # Allow all IPv6 addresses
  #   }
  # ]
  tags = {
    Environment = "dev"
    Name        = local.db_name
  }
}
