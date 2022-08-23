data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "ubuntu" {
  key_name   = "ubuntu"
  public_key = file("~/.ssh/GenProd.pub")
}

resource "aws_instance" "flask" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  key_name        = aws_key_pair.ubuntu.key_name
  
  vpc_security_group_ids = [ 
    aws_security_group.flask_api_sg.id
  ]
  tags = {
    Name = "flask"
  }
}

resource "aws_instance" "master" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  key_name        = aws_key_pair.ubuntu.key_name
  
  vpc_security_group_ids = [ 
    aws_security_group.db_servers_sg.id
  ]
  tags = {
    Name = "master"
  }
}

resource "aws_instance" "replica" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  key_name        = aws_key_pair.ubuntu.key_name
  
  vpc_security_group_ids = [ 
    aws_security_group.db_servers_sg.id
  ]
  tags = {
    Name = "replica"
  }
}