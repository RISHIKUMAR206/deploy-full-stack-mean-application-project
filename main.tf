provider "aws" {
  region = "ap-south-1" # Mumbai Region
}

resource "aws_security_group" "rishi_sg" {
  name        = "rishi-mumbai-sg"
  description = "Allow web and ssh traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "devops_server" {
  ami                    = "ami-0dee22c13ea7a9a67" 
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.rishi_sg.id]
  key_name               = "rishi-final-key" # <--- Ye line add karein

  tags = {
    Name = "Rishi-Mumbai-Server"
  }
}
