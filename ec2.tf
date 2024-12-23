provider "aws"{
    region="us-east-1"
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