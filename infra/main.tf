module "vpc" {
  source       = "./modules/terraform_vpc_simple"
  project_name = var.project_name
  aws_region   = "us-west-2"
}

module "sg_web" {
  source           = "./modules/terraform_security_group"
  sg_name          = "web_sg"
  sg_description   = "Allows HTTP/HTTPS and SSH access"
  project_name     = var.project_name
  vpc_id           = module.vpc.vpc_id
  ingress_rules    = [
    {
      description = "SSH access from home"
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_ipv4   = var.home_net
      rule_name   = "ssh_access_home"
    },
    {
      description = "SSH access from BCIT"
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_ipv4   = var.bcit_net
      rule_name   = "ssh_access_bcit"
    },
    {
      description = "HTTP access"
      ip_protocol = "tcp"
      from_port   = 80
      to_port     = 80
      cidr_ipv4   = "0.0.0.0/0"
      rule_name   = "http_access"
    },
    {
      description = "HTTPS access"
      ip_protocol = "tcp"
      from_port   = 443
      to_port     = 443
      cidr_ipv4   = "0.0.0.0/0"
      rule_name   = "https_access"
    }
  ]
  egress_rules = [
    {
      description = "Allow all outbound traffic"
      ip_protocol = "-1"
      from_port   = 0
      to_port     = 0
      cidr_ipv4   = "0.0.0.0/0"
      rule_name   = "allow_all_outbound"
    }
  ]
}

module "sg_be" {
  source           = "./modules/terraform_security_group"
  sg_name          = "be_sg"
  sg_description   = "Backend security group"
  project_name     = var.project_name
  vpc_id           = module.vpc.vpc_id
  ingress_rules    = [
    {
      description = "SSH access from home"
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_ipv4   = var.home_net
      rule_name   = "ssh_access_home_be"
    },
    {
      description = "SSH access from BCIT"
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_ipv4   = var.bcit_net
      rule_name   = "ssh_access_bcit_be"
    },
    {
      description = "Allow all traffic from the VPC"
      ip_protocol = "-1"
      from_port   = 0
      to_port     = 0
      cidr_ipv4   = var.vpc_cidr
      rule_name   = "all_traffic_from_vpc"
    }
  ]
  egress_rules = [
    {
      description = "Allow all outbound traffic"
      ip_protocol = "-1"
      from_port   = 0
      to_port     = 0
      cidr_ipv4   = "0.0.0.0/0"
      rule_name   = "allow_all_outbound_be"
    }
  ]
}

module "sg_db" {
  source          = "./modules/terraform_security_group"
  sg_name         = "db_sg"
  sg_description  = "RDS security group"
  project_name    = var.project_name
  vpc_id          = module.vpc.vpc_id
  ingress_rules   = [
    {
      description = "MySQL access from BE subnet"
      ip_protocol = "tcp"
      from_port   = 3306
      to_port     = 3306
      cidr_ipv4   = module.vpc.be_subnet_cidr
      rule_name   = "mysql_access_from_be"
    }
  ]
  egress_rules    = [
    {
      description = "MySQL traffic to BE subnet"
      ip_protocol = "tcp"
      from_port   = 3306
      to_port     = 3306
      cidr_ipv4   = module.vpc.be_subnet_cidr
      rule_name   = "mysql_traffic_to_be"
    }
  ]
}



module "web_ec2" {
  source = "./modules/terraform_ec2_simple"
  project_name = var.project_name
  aws_region = var.aws_region
  ami_id = var.ami_id
  subnet_id = module.vpc.web_subnet_id
  security_group_id = module.sg_web.sg_id
  ssh_key_name = var.ssh_key_name
  instance_tags     = {
    Name = "Web"
    Project = var.project_name
    Server_Type = "web"
  }
  
}

module "be_ec2" {
  source = "./modules/terraform_ec2_simple"
  project_name = var.project_name
  aws_region = var.aws_region
  ami_id = var.ami_id
  subnet_id = module.vpc.be_subnet_id
  security_group_id = module.sg_be.sg_id
  ssh_key_name = var.ssh_key_name
  instance_tags     = {
    Name = "Backend"
    Project = var.project_name
    Server_Type = "backend"
  }
}

module "rds" {
  source            = "./modules/terraform_RDS_simple"
  subnet_ids        = [module.vpc.db_1_subnet_id, module.vpc.db_2_subnet_id]
  allocated_storage = var.allocated_storage
  db_instance_class = var.db_instance_class
  sg_ids = [ module.sg_db.sg_id ]
  // Add any other required variables here
}

# https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "group_vars_file" {

  content = <<EOF
web_ec2_instance_public_dns: ${module.web_ec2.ec2_instance_public_dns}
backend_ec2_instance_public_dns: ${module.be_ec2.ec2_instance_public_dns}
database_endpoint: ${module.rds.rds_address}
EOF

  filename = "../service/group_vars/variables.yml"

}

