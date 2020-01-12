###############################################################################
# EC2
###############################################################################

# data "aws_ami" "ubuntu" {

#   owners      = ["canonical"]
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

# }

# output "aws_ubuntu_ami" {
#   value = data.aws_ami.ubuntu.id
# }

resource "aws_instance" "ec2_jm" {

  #ami                    = data.aws_ami.aws_linux.id
  ami                    = var.ec2_ami
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_01.id
  vpc_security_group_ids = [aws_security_group.security_group_jm.id]
  key_name               = var.key_name

  tags = {
    name = "Concourse on Ubuntu"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    //user        = "ec2-user"
    user        = var.ec2_user
    private_key = file(var.private_key_path)
  }

  provisioner "file" {
    content     = <<-EOF
version: '3'

services:
  concourse-db:
    image: postgres
    environment:
      POSTGRES_DB: concourse
      POSTGRES_PASSWORD: concourse_pass
      POSTGRES_USER: concourse_user
      PGDATA: /database

  concourse:
    image: concourse/concourse
    command: quickstart
    privileged: true
    depends_on: [concourse-db]
    ports: ["8080:8080"]
    environment:
      CONCOURSE_POSTGRES_HOST: concourse-db
      CONCOURSE_POSTGRES_USER: concourse_user
      CONCOURSE_POSTGRES_PASSWORD: concourse_pass
      CONCOURSE_POSTGRES_DATABASE: concourse
      CONCOURSE_EXTERNAL_URL: http://${aws_instance.ec2_jm.public_dns}:8080
      CONCOURSE_ADD_LOCAL_USER: test:test
      CONCOURSE_MAIN_TEAM_LOCAL_USER: test
      CONCOURSE_WORKER_BAGGAGECLAIM_DRIVER: overlay
    EOF

    destination = "docker-compose.yaml"
  }

   provisioner "remote-exec" {
     inline = [
"sudo apt update",
"sudo rm /boot/grub/menu.lst",
"sudo update-grub-legacy-ec2 -y",
"sudo apt upgrade -y",
"sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y",
"curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
"sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"",
"sudo apt update",
"sudo apt install docker-ce docker-ce-cli containerd.io -y",
"sudo curl -L https://github.com/docker/compose/releases/download/1.25.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose",
"sudo chmod +x /usr/local/bin/docker-compose",
"export CONCOURSE_EXTERNAL_URL=concourse.morsley.uk",
"sudo docker-compose up -d",
    ]
  }

  #user_data = file("concourse.sh")

  #depends_on = [data.aws_ami.aws_linux]

}

###############################################################################
# OUTPUT
###############################################################################

output "aws_instance_public_dns" {
  value = aws_instance.ec2_jm.public_dns
}