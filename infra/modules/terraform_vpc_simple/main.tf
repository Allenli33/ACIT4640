provider "aws" {
  region = var.aws_region
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "a03_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name    = "a03_vpc"
    Project = var.project_name
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "web" {
  vpc_id                  = aws_vpc.a03_vpc.id
  cidr_block              = var.web_subnet_cidr
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name    = "web"
    Project = var.project_name
  }

}

resource "aws_subnet" "be" {
  vpc_id                  = aws_vpc.a03_vpc.id
  cidr_block              = var.be_subnet_cidr
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name    = "be"
    Project = var.project_name
  }

}

resource "aws_subnet" "db_1" {
  vpc_id                  = aws_vpc.a03_vpc.id
  cidr_block              = var.db1_subnet_cidr
  availability_zone = "us-west-2a"
  tags = {
    Name    = "db_1"
    Project = var.project_name
  }

}

resource "aws_subnet" "db_2" {
  vpc_id                  = aws_vpc.a03_vpc.id
  cidr_block              = var.db2_subnet_cidr
  availability_zone = "us-west-2b"
  tags = {
    Name    = "db_2"
    Project = var.project_name
  }

}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "gw_a03" {
  vpc_id = aws_vpc.a03_vpc.id

  tags = {
    Name    = "gw_a03"
    Project = var.project_name
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "rt_a03" {
  vpc_id = aws_vpc.a03_vpc.id

  route {
    cidr_block = var.default_route
    gateway_id = aws_internet_gateway.gw_a03.id
  }

  tags = {
    Name    = "rt_a03"
    Project = var.project_name
  }
}

resource "aws_route_table_association" "web_rt_assoc" {
  subnet_id      = aws_subnet.web.id
  route_table_id = aws_route_table.rt_a03.id
}

resource "aws_route_table_association" "be_rt_assoc" {
  subnet_id      = aws_subnet.be.id
  route_table_id = aws_route_table.rt_a03.id
}

resource "aws_route_table_association" "db1_rt_assoc" {
  subnet_id      = aws_subnet.db_1.id
  route_table_id = aws_route_table.rt_a03.id
}

resource "aws_route_table_association" "db2_rt_assoc" {
  subnet_id      = aws_subnet.db_2.id
  route_table_id = aws_route_table.rt_a03.id
}