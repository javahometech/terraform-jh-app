# Create a new load balancer

data "aws_availability_zones" "available" {}

resource "aws_elb" "jh_elb" {
  name               = "jh-terraform-elb"
  security_groups    = ["${aws_security_group.allow_all.id}"]
  subnets = ["${aws_subnet.subnets.*.id}"]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 30
  }

  instances                   = ["${aws_instance.instances.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "jh-app-terraform-elb"
  }
}

output "elb-dns" {
  value = "${aws_elb.jh_elb.dns_name}"
}
