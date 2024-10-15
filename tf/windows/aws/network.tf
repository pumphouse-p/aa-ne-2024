resource "aws_vpc" "windows" {
  cidr_block           = "10.144.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "windows"
  }
}

resource "aws_subnet" "windows" {
  vpc_id                              = aws_vpc.windows.id
  cidr_block                          = "10.144.0.0/24"
  private_dns_hostname_type_on_launch = "ip-name"
  map_public_ip_on_launch             = true

  tags = {
    Name = "windows"
  }
}

resource "aws_internet_gateway" "windows" {
  vpc_id = aws_vpc.windows.id

  tags = {
    Name = "windows"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_vpc.windows.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.windows.id
}

resource "aws_security_group" "windows" {
  name   = "windows"
  vpc_id = aws_vpc.windows.id

  ingress {
    description = "Allow WinRM"
    from_port   = 5985
    to_port     = 5986
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow RDP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
