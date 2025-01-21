resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "web_sg" {
  name_prefix = "web-sg-"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

resource "aws_instance" "web_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.key_pair.key_name

  security_groups = [
    aws_security_group.web_sg.name,
  ]

  tags = {
    Name = "WebServer"
  }
}
