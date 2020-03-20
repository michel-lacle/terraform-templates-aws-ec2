
resource "aws_instance" "example" {
  count	        = 1
  ami           = "ami-0a887e401f7654935"
  instance_type = "t2.micro"
  
  key_name = "ExampKP"

  vpc_security_group_ids = ["sg-0d9a3a138f6746c16"]

 tags = {
    owner = "terraform-templates-aws-ec2"
  }
}

# output "aws_instance_ip" {

#   value = aws_instance.example[0].public_ip
#   description = "The public IP address of our instance"
# }
