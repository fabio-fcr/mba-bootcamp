resource "aws_vpc" "bootcamp" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "bootcamp"
  }
}


resource "aws_subnet" "bootcamp-private-subnet" {
  vpc_id            = aws_vpc.bootcamp.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "bootcamp-private-subnet"
  }
}

resource "aws_subnet" "bootcamp-public-subnet" {
  vpc_id            = aws_vpc.bootcamp.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "bootcamp-public-subnet"
  }
}

resource "aws_internet_gateway" "bootcamp-igw" {
  vpc_id = aws_vpc.bootcamp.id

  tags = {
    Name = "bootcamp-iwg"
  }
}

resource "aws_internet_gateway_attachment" "bootcamp-igw-attach" {
  count               = 0
  internet_gateway_id = aws_internet_gateway.bootcamp-igw.id
  vpc_id              = aws_vpc.bootcamp.id
}

resource "aws_route_table" "bootcamp-public-rt" {
  vpc_id = aws_vpc.bootcamp.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bootcamp-igw.id
  }

  tags = {
    Name = "bootcamp-public-rt"
  }
}