terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "toy_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "toy_subnet" {
  vpc_id     = aws_vpc.toy_vpc.id
  cidr_block = "10.0.0.0/24"
}

resource "aws_internet_gateway" "toy_igw" {
  vpc_id = aws_vpc.toy_vpc.id
}

resource "aws_route_table" "toy_route_table" {
  vpc_id = aws_vpc.toy_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.toy_igw.id
  }
}

resource "aws_route_table_association" "toy_route_table_association" {
  subnet_id      = aws_subnet.toy_subnet.id
  route_table_id = aws_route_table.toy_route_table.id
}

resource "aws_instance" "app_server" {
  ami           = "ami-0094635555ed28881"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.toy_subnet.id

  tags = {
    Name = var.instance_name
  }
}
