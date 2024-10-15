resource "aws_vpc" "multicloud_demo" {
  cidr_block           = "10.122.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "multicloud"
  }
}

resource "aws_subnet" "multicloud_demo" {
  vpc_id                              = aws_vpc.multicloud_demo.id
  cidr_block                          = "10.122.0.0/24"
  private_dns_hostname_type_on_launch = "ip-name"
  map_public_ip_on_launch             = true

  tags = {
    Name = "multicloud"
  }
}

resource "aws_internet_gateway" "multicloud_demo" {
  vpc_id = aws_vpc.multicloud_demo.id

  tags = {
    Name = "multicloud"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_vpc.multicloud_demo.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.multicloud_demo.id
}

resource "aws_security_group" "multicloud_demo" {
  name   = "multicloud"
  vpc_id = aws_vpc.multicloud_demo.id

  ingress {
    description = "Allow ingress 22/tcp"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ingress 80/tcp"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ingress 443/tcp"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ingress 8080/tcp"
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ingress 9000/tcp"
    from_port   = "9000"
    to_port     = "9000"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
