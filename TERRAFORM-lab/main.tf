terraform {
  backend "s3" {
    bucket = "terraform-bucked"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
//
resource "aws_vpc" "my_vpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}
//
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-igw"
  }
}
//
resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-1"
  }
}
resource "aws_subnet" "subnet_2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-2"
  }
}
//
resource "aws_route_table" "route_table_1" {
  vpc_id = aws_vpc.my_vpc.id
}
resource "aws_route_table_association" "subnet_1_association" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.route_table_1.id
}
resource "aws_route_table_association" "subnet_2_association" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.route_table_1.id
}
resource "aws_route" "internet_gateway_route" {
  route_table_id         = aws_route_table.route_table_1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}
//
resource "aws_instance" "instance_1a" {
  ami           = "ami-0326f60a47135bbcb"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_1.id
  tags = {
    Name = "instance-1a"
  }
}
resource "aws_instance" "instance_1b" {
  ami           = "ami-0326f60a47135bbcb"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_1.id
  tags = {
    Name = "instance-1"
  }
}