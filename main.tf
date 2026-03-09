
resource "aws_instance" "PHP_Server" {
  ami                    = "ami-0220d79f3f480ecf5"
  vpc_security_group_ids = [aws_security_group.Allow_All.id]
  instance_type          = "t3.small"

  user_data = file("userdata.sh")

  root_block_device {
    volume_size           = 50
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name    = "PHP_Server"
  }
}


resource "aws_security_group" "Allow_All" {
  name        = "Allow_All"
  description = "allow-all with out any restriciton"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "allow_all"
  }
}
