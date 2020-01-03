###############################################################################
# EC2
###############################################################################

resource "aws_instance" "ec2_concourse" {

  ami                    = var.ec2_ami
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_01.id
  vpc_security_group_ids = [aws_security_group.security_group_concourse.id]
  key_name               = var.key_name

  connection {
   type        = "ssh"
   host        = self.public_ip
   user        = "ubuntu"
   private_key = file(var.private_key_path)
  }

}

###############################################################################
# OUTPUT
###############################################################################

output "aws_instance_public_dns" {
  value = aws_instance.ec2_concourse.public_dns
}