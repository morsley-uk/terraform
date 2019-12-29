###############################################################################
# EC2
###############################################################################

data "aws_ami" "aws_linux" {

  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

resource "aws_instance" "ec2_jm" {

  ami                    = data.aws_ami.aws_linux.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_01.id
  vpc_security_group_ids = [aws_security_group.security_group_jm.id]
  key_name               = var.key_name

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install nginx -y",
      "sudo service nginx start"
    ]
  }

  depends_on = [data.aws_ami.aws_linux]

}

###############################################################################
# OUTPUT
###############################################################################

output "aws_instance_public_dns" {
  value = aws_instance.ec2_jm.public_dns
}