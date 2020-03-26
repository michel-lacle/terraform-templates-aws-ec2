resource "aws_security_group" "ec2-sg-ebs" {
  name = "ec2-sg-ebs"
  description = "Allow ssh & http inbound traffic"
  vpc_id = "vpc-bb9f3bc0"

  ingress {
    description = "TLS from VPC"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  # this is needed to allow the ec2 instance to access the external
  # world, for example when you need to do a yum update.
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = {
    owner = "terraform-templates-aws-ec2"
    project = "terraform-templates-aws-ec2"
  }
}

resource "aws_instance" "ec2-ebs" {
  ami = "ami-0a887e401f7654935"
  instance_type = "t2.micro"

  # this is optional, but needed if you want to ssh into your ec2 instance
  # here I have manually created a key pair in the console and I'm supplying the
  # name.
  key_name = "terraform-templates-aws-ec2"

  vpc_security_group_ids = [
    aws_security_group.ec2-sg-ebs.id]

  /*
  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = 500
    volume_type = "sc1"
    delete_on_termination = false
  }

  ebs_block_device {
    device_name = "/dev/sdc"
    volume_size = 500
    volume_type = "st1"
    delete_on_termination = false
  }

  ebs_block_device {
    device_name = "/dev/sdd"
    volume_size = 8
    volume_type = "standard"
    delete_on_termination = false
  }*/

  tags = {
    Name = "ec2-ebs"
    owner = "terraform-templates-aws-ec2"
    project = "terraform-templates-aws-ec2"
  }
}

output "aws_instance_ip_ebs" {

  value = aws_instance.ec2-ebs.public_ip
  description = "The public IP address of our instance"
}
