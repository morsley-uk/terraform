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

  provisioner "remote-exec" {
    inline = [
      #"sudo apt update",
      #"sudo apt-get update",
      #"sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y",
      #"curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      #"sudo apt-key fingerprint 0EBFCD88",
      #"sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"",
      #"sudo apt-get update",
      #"sudo apt-get install docker-ce docker-ce-cli containerd.io -y",
      #"sudo groupadd docker",
      #"sudo usermod -aG docker $USER",
      #"sudo docker info",
      #"sudo curl -L https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose",
      #"sudo chmod +x /usr/local/bin/docker-compose",
      #"sudo docker-compose version",
      #"sudo wget https://concourse-ci.org/docker-compose.yml",
      #"sudo docker-compose up --detach",
      #"sudo docker-compose up --no-start",
      #"sudo apt-get install gedit -y",
      #"CONCOURSE_EXTERNAL_URL=http://${aws_instance.ec2_concourse.public_dns}:8080",
      #"sudo -H gedit /etc/environment"
      #"printenv CONCOURSE_EXTERNAL_URL",
      #"sudo docker-compose start"
    ]
  }

  provisioner "local-exec" {
    command = "echo $CONCOURSE_EXTERNAL_URL >> /etc/environment"
    environment = {
      CONCOURSE_EXTERNAL_URL="http://${aws_instance.ec2_concourse.public_dns}:8080"
    }
  }

}

###############################################################################
# OUTPUT
###############################################################################

output "aws_instance_public_dns" {
  value = aws_instance.ec2_concourse.public_dns
}