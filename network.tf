resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags       = {
    Name     = "${local.env_prefix}-vpc"
  }
}
resource "aws_subnet" "myapp-subnet" {
  count             = local.count
  vpc_id            = aws_vpc.myapp-vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block,8,count.index)
  availability_zone = var.availability_zone[count.index]
  tags              = {
    Name            = "${local.env_prefix}-subnet-1"
  }
}

resource "aws_internet_gateway" "myapp-igw" {
  vpc_id            = aws_vpc.myapp-vpc.id
  tags              = {
    Name            = "${local.env_prefix}-igw"
  }
}

resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
  route {
    cidr_block           = local.any_where
    gateway_id           = aws_internet_gateway.myapp-igw.id
  }
  tags                   = {
    Name                 = "${local.env_prefix}-main-rtb"
  }
}

resource "aws_default_security_group" "default-sg" {
  vpc_id        = aws_vpc.myapp-vpc.id
  ingress {
    from_port   = local.ssh_port
    to_port     = local.ssh_port
    protocol    = local.protocol
    cidr_blocks = [local.any_where]
  }
  ingress {
    from_port   = local.app_port
    to_port     = local.app_port
    protocol    = local.protocol
    cidr_blocks = [local.any_where]
  }
  egress {
    from_port   = local.all_ports
    to_port     = local.all_ports
    protocol    = local.any_protocol
    cidr_blocks = [local.any_where]
  }
  tags = {
    Name = "${local.env_prefix}-default-sg"
  }
}
