provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "demo-server" {
  ami             = "ami-0e670eb768a5fc3d4"
  instance_type   = "t2.micro"
  key_name        = "dpp"
  security_groups = ["demo-sg"]
  tags = {
    Name = "Demo-Server"
  }
}

resource "aws_security_group" "demo_sg" {
  name        = "demo-sg"
  description = "Allow inbound traffic and all outbound traffic"

  tags = {
    Name = "Demo-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
  security_group_id = aws_security_group.demo_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.demo_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.demo_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.demo_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}