resource "aws_instance" "instances" {
  count                       = "${length(var.subnets_cidr)}"
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  user_data                   = "${file("install-apache.sh")}"
  associate_public_ip_address = true
  subnet_id                   = "${element(aws_subnet.subnets.*.id, count.index)}"
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  key_name                    = "${var.ec2_key}"
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all_terraform"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.jh-vpc.id}"

  # Inbound rule
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
