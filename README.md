# min-EC2-Terra
This repo shows how we can create an EC2 instance for a project with the bare minimum requirements necessary for it. 

## Steps to apply this:
For our project, the prerequisites are:
1. Download and install Terraform. Download: <a href="https://www.terraform.io/">Link</a>, Install: <a href="https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli">Link</a>. 
2. Use the given link and follow as per instructions, <a href="https://docs.google.com/document/d/1_FckCr6VTwdX_9NihxZCNxI4E9yp39FVMKezc0iYx2o/edit">Link</a>.
3. Download and install AWS CLI. Follow the given <a href="https://www.howtogeek.com/devops/how-to-install-and-configure-the-aws-cli/">Link</a> for instructions.
4. Provide AWS credentials in the CLI. Also shown in the above link.
5. See if everything is installed and working correctly.
6. Open Editor and create the necessary files.

In order to make an EC2 instance in Terraform with the absolutely mandatory resources needed are given and the steps are also shown below:
1. <b>Provider:</b> We need to make a provider file which will contain the provider we are working with. In our case the provider is AWS. <u>Dependencies:</u> Region must be provided.
2. <b>VPC:</b> To make an EC2 instance we need a VPC. To create a VPC we need to create a CIDR block. <u>Dependencies:</u> CIDR block must be provided.
3. <b>Subnet:</b> The next resource we need is a Subnet. The subnet will have the id to the VPC and a CIDR block. <u>Dependencies:</u> VPD ID and CIDR block must be provided.
4. <b>EC2:</b> Finally we need to create the EC2 instance. The EC2 instance will have the AMI id, subnet id and the instance type. <u>Dependencies:</u> AMI ID, Subnet ID and Instance Type/Launch Template must be provided.

The code that we have added in the repo is to make the EC2 instance with our own made subnet. The files are explained below:<br>
1. <b>provider.tf:</b> This file is made to ensure that we are using the aws service provider. It is not necessary to mention what the region we are using, or the "aws" provider name unless we apply it during the aws configuration through aws cli. The codes are given below:<br>
<code>provider "aws" {
}</code>
2. <b>vpc.tf:</b> This file contains the minimum necessary requirements for making a vpc. The vpc will contain a CIDR block without which it cannot be made. The subnet also needs the vpc id and the CIDR block without which it will not work. The code is shown below:<br>
<code>//VPC 
resource "aws_vpc" "fazle-vpc" {
  cidr_block = "192.168.56.0/28"
}
//Subnet
resource "aws_subnet" "fazle-subnet" {
  vpc_id     = aws_vpc.fazle-vpc.id
  cidr_block = "192.168.56.0/28"
}
</code>
3. <b>ec2.tf:</b> The final file will contain our ec2 instance. It will contain the necessary parameters like the ami, the subnet id and the instance type. We can make the EC2 instance without specifying the subnet ID but it will use the default subnet of the region instead of the one which was made. There are many ways to retrieve the ami for example: directly giving the ami id, using a variable to insert the ami id, using the ami from a launch template or by using data block to retrieve the ami id using filters which was the way used in the code given below:
<code>
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
  instance_type = "t2.micro"
}
</code>

After we have created our files with the necessary codes, we must make sure the required plugins are installed after which we have to go through different steps to totally apply the terraform infrastructure.
1. Type “terraform init” and hit enter. Needed to install the necessary plugins.
2. Type “terraform validate” and hit enter. Needed to ensure there are no Syntax errors and check reusable modules, including correctness of attribute names and value types in code.
3. Type “terraform plan” and hit enter. Needed to see the things which will be added, changed or destroyed.
4. Type “terraform apply” and hit enter. Needed to apply the infrastructure
5. Type “yes” when the prompt comes if sure to apply. Needed to make sure again that the infrastructure will surely be applied.

