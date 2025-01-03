provider "aws"{
    region="us-west-2"
}
data "aws_ami" "latest_ami" {
  most_recent = "true"
  owners = ["amazon"]

  filter {
    name= "name"
    values= ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}
resouce "aws_security_group""my_sg" {
    name= "my_sg"
    description= "TCP"
    ingress {
        from_port  = 22 
        to_port = 22
        protocol = "TCP"
        cidr_blocks =["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_instance" "my-instance" {
  ami=var.image_id
  instance_type= "t2.micro"
  key_name= ""
  vpc_security_group_ids=[aws_security_group.my_sg.id]
  user_data= <<EOF 
      #!/bin/bash
      yum update 
      yum install httpd -y
      systemctl start httpd
      systemctl enable httpd
      echo "hello kuldeep" > /var/www/html/index.html
      EOF
}
variable "image_id" {
    type= string
    default=""
    description="Enter_my_value"
}
output "kuldeep"{
    value= aws_instance.my-instance.public_ip
}