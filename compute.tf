
# EC2 Key Pair

resource "aws_key_pair" "terraform_key" {

  key_name = "terraform-key"

  public_key = file("${path.module}/ssh-key/terraform-key.pub")

}

# Ubuntu AMI


data "aws_ami" "ubuntu" {

  most_recent = true

  owners = ["099720109477"]

  filter {

    name = "name"

    values = [
      "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    ]
  }

  filter {

    name = "virtualization-type"

    values = [
      "hvm"
    ]

  }

}


# EC2 Instance


resource "aws_instance" "webserver" {

  ami = data.aws_ami.ubuntu.id

  instance_type = var.instance_type

  subnet_id = aws_subnet.public.id

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  key_name = aws_key_pair.terraform_key.key_name

  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }

}