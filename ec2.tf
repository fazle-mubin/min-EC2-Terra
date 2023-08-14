//Latest AWS Linux AMI
data "aws_ami" "aws-Linux-Latest" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

//EC2 Instance Creation
resource "aws_instance" "fazle-EC2" {
  ami           = data.aws_ami.aws-Linux-Latest.id
  subnet_id     = aws_subnet.fazle-subnet.id
  //instance_type = "t2.micro"
}