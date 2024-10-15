data "aws_ami" "rhel_9" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-9.2.0_HVM-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["309956199498"]
}

resource "aws_instance" "multicloud_demo" {
  count                       = var.instance_count
  ami                         = data.aws_ami.rhel_9.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.multicloud_demo.id
  associate_public_ip_address = true
  key_name                    = var.key_name

  root_block_device {
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "gp2"

    tags = {
      Name = "multicloud-demo-${count.index}"
    }
  }

  vpc_security_group_ids = [
    aws_security_group.multicloud_demo.id
  ]

  tags = {
    Name         = "multicloud-demo-${count.index}"
    purpose      = "webserver"
    ansible_user = "ec2-user"
    created_by   = "ansible"
  }

#   user_data = <<EOF
# #!/bin/bash
# echo "Calling back to Ansible Automation Platform for post-provisioning setup."
# curl -k -f -i -H 'Content-Type:application/json' -XPOST -d '{"host_config_key": "my-key"}' https://controller.example.com/api/v2/job_templates/136/callback/
# EOF
# }

resource "aws_ebs_volume" "multicloud_demo" {
  count             = var.instance_count
  availability_zone = element(aws_instance.multicloud_demo.*.availability_zone, count.index)
  size              = 10

  tags = {
    Name = "multicloud-demo-${count.index}"
  }
}

resource "aws_volume_attachment" "multicloud_demo" {
  count       = var.instance_count
  device_name = "/dev/xvdf"
  volume_id   = element(aws_ebs_volume.multicloud_demo.*.id, count.index)
  instance_id = element(aws_instance.multicloud_demo.*.id, count.index)
}
