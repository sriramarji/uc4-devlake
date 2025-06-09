resource "aws_vpc" "myvpc" {                                 #VPC
  cidr_block = var.vpc_cidr
  tags = {
    Name = "alb-vpc"
  }
}

resource "aws_internet_gateway" "igw" {                           #IGW
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "alb-igw"
  }
}

resource "aws_route_table" "public_rt" {                              #route table
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_subnet" "mysub-1" {                                     #subnet creation
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.sub_cidr[0]
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "mysub-2" {                                         #subnet creation
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.sub_cidr[1]
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_route" "public_igw" {                                       #route table and igw connection
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "pub_sub_asso-1" {                     #route table and subnet association
  subnet_id      = aws_subnet.mysub-1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "pub_sub_asso-2" {                       #route table and subnet association
  subnet_id      = aws_subnet.mysub-2.id
  route_table_id = aws_route_table.public_rt.id
}