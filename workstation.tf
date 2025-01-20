module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type          = "t2.micro"
  ami = data.aws_ami.Centos8.id
#   key_name               = "user1"
#   monitoring             = true
  vpc_security_group_ids = [aws_security_group.allow_minikube.id]
  subnet_id              = "subnet-08552b8a3fc9570b4" # replace your SG
  user_data = file("docker.sh")
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "allow_minikube" {
  name        = "allow_minikube"
  description = "Allow TLS inbound traffic and all outbound traffic from minikube"
# we use default vpc
  ingress {
    description = "all ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_tls"
  }
}