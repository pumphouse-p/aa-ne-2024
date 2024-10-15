data "aws_ami" "windows_2019" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["801119661308"]
}

resource "aws_instance" "windows" {
  count                       = var.instance_count
  ami                         = data.aws_ami.windows_2019.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.windows.id
  associate_public_ip_address = true
  key_name                    = var.key_name

  root_block_device {
    delete_on_termination = true
    volume_size           = 100
    volume_type           = "gp2"

    tags = {
      Name    = "windows-${count.index}"
      purpose = "windows"
    }
  }

  user_data = file("${path.module}/winrm.ps1")

  vpc_security_group_ids = [
    aws_security_group.windows.id
  ]

  tags = {
    Name       = "windows-${count.index}"
    purpose    = "windows"
    created_by = "ansible"
    os_type    = "windows"
  }
}
