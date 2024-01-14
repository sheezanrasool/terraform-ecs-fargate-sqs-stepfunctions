resource "aws_eip" "nat1" {
  domain = "vpc"

  tags = {
    Name = "EIP-NAT1"
  }
}

resource "aws_eip" "nat2" {
  domain = "vpc"

  tags = {
    Name = "EIP-NAT2"
  }
}


resource "aws_nat_gateway" "nat-1a" {
  allocation_id = aws_eip.nat1.id
  subnet_id     = values(aws_subnet.AM-public-subnet)[0].id

  tags = {
    Name = "nat-1a"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat-1b" {
  allocation_id = aws_eip.nat2.id
  subnet_id     = values(aws_subnet.AM-public-subnet)[1].id

  tags = {
    Name = "nat-1b"
  }

  depends_on = [aws_internet_gateway.igw]
}