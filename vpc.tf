resource "aws_vpc" "jh-vpc" {
  cidr_block = "${var.vpc_cidr}"

  tags {
    Name = "JavaHomeVPC"
  }
}

# IGW for JavaHomeVPC
resource "aws_internet_gateway" "javahome-igw" {
  vpc_id = "${aws_vpc.jh-vpc.id}"
}

resource "aws_subnet" "subnets" {
  count             = "${length(var.subnets_cidr)}"
  availability_zone = "${element(var.azs,count.index)}"
  cidr_block        = "${element(var.subnets_cidr,count.index)}"
  vpc_id            = "${aws_vpc.jh-vpc.id}"

  tags {
    Name = "Subnet-${count.index + 1}"
  }
}

# Create route tables for public subnets`

resource "aws_route_table" "public-rt" {
  vpc_id = "${aws_vpc.jh-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.javahome-igw.id}"
  }
}

# Associate public route table with public subnets

resource "aws_route_table_association" "rt_asociation" {
  count          = "${length(var.subnets_cidr)}"
  subnet_id      = "${element(aws_subnet.subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.public-rt.id}"
}
