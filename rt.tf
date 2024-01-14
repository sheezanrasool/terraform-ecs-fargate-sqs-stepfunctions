resource "aws_route_table" "private-1a" {
  vpc_id = aws_vpc.AM-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-1a.id
  }
tags = {
    Name = "private-1a"
  }
}
  

resource "aws_route_table" "private-1b" {
  vpc_id = aws_vpc.AM-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-1b.id
  }
  tags = {
    Name = "private-1b"
  }
}
  

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.AM-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "private-us-east-1a" {
  subnet_id      = values(aws_subnet.AM-private-subnet)[0].id
  route_table_id = aws_route_table.private-1a.id
}

resource "aws_route_table_association" "private-us-east-1b" {
  subnet_id      = values(aws_subnet.AM-private-subnet)[1].id
  route_table_id = aws_route_table.private-1b.id
}

resource "aws_route_table_association" "DB-private-us-east-1a" {
  subnet_id      = values(aws_subnet.AM-DB-subnet)[0].id
  route_table_id = aws_route_table.private-1a.id
}

resource "aws_route_table_association" "DB-private-us-east-1b" {
  subnet_id      = values(aws_subnet.AM-DB-subnet)[1].id
  route_table_id = aws_route_table.private-1b.id
}
resource "aws_route_table_association" "public-us-east-1a" {
  subnet_id      = values(aws_subnet.AM-public-subnet)[0].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-us-east-1b" {
  subnet_id      = values(aws_subnet.AM-public-subnet)[1].id
  route_table_id = aws_route_table.public.id
}
