module "minikube" {
  source = "github.com/PramodCodes/terraform-aws-minikube-module"

  aws_region    = "us-east-1"
  cluster_name  = "roboshop"
  aws_instance_type = "t3.medium"
  ssh_public_key = "~/.ssh/id_rsa.pub" #get your public key from /users/username/.ssh/ and use here
  aws_subnet_id = "subnet-08552b8a3fc9570b4" #replace with your default subnet id
  ami_image_id = "ami-0b4f379183e5706b9" # this is built on centos 7 but i am trying with 8
  hosted_zone = "pka.in.net"
  hosted_zone_private = false

  tags = {
    Application = "Minikube"
  }

  addons = [
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/storage-class.yaml",
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/heapster.yaml",
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/dashboard.yaml",
    "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/external-dns.yaml"
  ]
}