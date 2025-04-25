resource "aws_eip" "nat_eip" {
  vpc = true

  tags = {
    Name = "${var.project_name}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_id
  tags = {
    Name = "${var.project_name}-nat-gw"
  }

  depends_on = [var.igw_id] # NAT Gateway depends on IGW being ready
}

