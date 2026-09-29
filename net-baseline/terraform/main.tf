locals {
  name = "${var.environment}-net"
}

resource "aws_vpc" "this" {
  cidr_block         = var.vpc_cidr
  enable_dns_support = true
  tags = {
    Name = local.name
  }
}

resource "aws_subnet" "private" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.this.id
  availability_zone = var.azs[count.index]
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 1)
  tags = {
    Name = "${local.name}-private-${var.azs[count.index]}"
  }
}

resource "aws_security_group" "mgmt" {
  name   = "${local.name}-mgmt"
  vpc_id = aws_vpc.this.id
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "private_subnet_ids" {
  value = aws_subnet.private.id
}
