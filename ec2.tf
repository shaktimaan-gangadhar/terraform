provider "aws"{
    region="us-east-1"
}
resouce "aws_security_group""my_sg" {
    name= "my_sg"
    description= "ssh"
    ingress {
        from_port  = 22 
        to_port = 22
        protocol = "SSH"
        cidr_blocks =["0.0.0.0/0"]
    }
    egress {
        from_port = 22
        to_port = 22
        protocol = "SSH"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_instance" "my-instance" {
  ami=var.image_id
  instance_type= "t2-micro"
  key_name= "hello.pem"
  security_groups=["defaults"]
}
variable "image_id" {
    type="string"
    default="ami-01816d07b1128cd2d"
    description="Enter_my_value"
}