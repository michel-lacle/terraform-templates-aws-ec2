resource "aws_security_group" "ec2-sg-webserver" {
  name = "ec2-sg-webserver"
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

  ingress {
    description = "http traffic"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

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

resource "aws_instance" "ec2-webserver" {
  ami = "ami-0a887e401f7654935"
  instance_type = "t2.micro"

  # this is optional, but needed if you want to ssh into your ec2 instance
  # here I have manually created a key pair in the console and I'm supplying the
  # name.
  key_name = "terraform-templates-aws-ec2"

  user_data = file("webserver_install.sh")

  vpc_security_group_ids = [
    aws_security_group.ec2-sg-webserver.id]

  tags = {
    owner = "terraform-templates-aws-ec2"
    project = "terraform-templates-aws-ec2"
  }
}

output "aws_instance_ip_webserver" {

  value = aws_instance.ec2-webserver.public_ip
  description = "The public IP address of our instance"
}
