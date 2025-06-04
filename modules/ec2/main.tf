resource "aws_instance" "web" {
  ami                    = var.ami_id #variabilise values 
  instance_type          = var.inst_type
  subnet_id              = var.subnet_ids[0]
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.inst_sg.id] # to launch instance under part SG

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y docker.io git curl
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo usermod -aG docker ubuntu
    sleep 10

    # Install Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    # Clone working DevLake repo with UI support
    cd /home/ubuntu
    git clone https://github.com/merico-dev/lake.git devlake
    cd devlake/
    cp -arp devops/releases/lake-v0.21.0/docker-compose.yml ./

    # Set up .env file
    cp env.example .env
    echo "ENCRYPTION_SECRET=super-secret-123" >> .env

    # Run Docker Compose
    sudo docker-compose up -d
    sleep 35
   EOF

  tags = {
    Name = "Docker"
  }
}

resource "aws_security_group" "inst_sg" {

  name   = "ec2-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 4000
    to_port     = 4000
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