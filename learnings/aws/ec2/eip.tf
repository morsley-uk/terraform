# resource "aws_eip" "concourse" {

#   instance = aws_instance.ec2_jm.id
#   vpc = true
#   depends_on = [aws_internet_gateway.igw_jm]

# }

# output "concourse_eip" {
#   value = aws_eip.concourse.public_ip
# }