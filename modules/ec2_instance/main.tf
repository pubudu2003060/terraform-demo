provider "aws" {
    region = "eu-north-1"
}

resource "aws_key_pair" "example" {
    key_name   = "terraform demo pubudu"
   public_key = file("~/.ssh/terraform_key.pub") # Updated path
}


resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr_block_value
}

resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "eu-north-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id = aws_subnet.sub1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "websg" {
  name = "web"
  vpc_id = aws_vpc.myvpc.id
  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "for flask app"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

resource "aws_instance" "example" {
    ami = var.ami_value
    instance_type = var.instance_type_value
    key_name = aws_key_pair.example.key_name
    vpc_security_group_ids = [aws_security_group.websg.id]
    subnet_id = aws_subnet.sub1.id
    associate_public_ip_address = true


   connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("~/.ssh/terraform_key")
        host = self.public_ip
    }

    provisioner "file" {
    source      = "app.py"  
    destination = "/home/ubuntu/app.py"  
  }

  provisioner "remote-exec" {
    inline = [
     "echo 'Hello from the remote instance'",
      "sudo apt update -y",
      "sudo apt-get install -y python3-pip",
      "sudo apt install -y python3-flask",
      "cd /home/ubuntu",
      "sudo bash -c 'cat <<EOF > /etc/systemd/system/flask-app.service\n[Unit]\nDescription=Flask App\nAfter=network.target\n\n[Service]\nUser=ubuntu\nWorkingDirectory=/home/ubuntu\nExecStart=/usr/bin/python3 /home/ubuntu/app.py\nRestart=always\n\n[Install]\nWantedBy=multi-user.target\nEOF'",
      "sudo systemctl enable flask-app.service",
      "sudo systemctl start flask-app.service",
      "sleep 5",
      "curl http://localhost:5000"
    ]
  }
}

