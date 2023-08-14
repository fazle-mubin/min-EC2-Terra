//VPC 
resource "aws_vpc" "fazle-vpc" {
  cidr_block = "192.168.56.0/28"
}

//Subnet
resource "aws_subnet" "fazle-subnet" {
  vpc_id     = aws_vpc.fazle-vpc.id
  cidr_block = "192.168.56.0/28"
}

