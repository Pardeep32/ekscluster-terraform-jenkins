#VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-my-vpc"
  cidr = var.vpc_cidr

  azs = data.aws_availability_zone.azs.*.name
  // private_subnets = ["10.0.1.0/24"]
  public_subnets = var.public_subnets

  // enable_nat_gateway = true
  // enable_vpn_gateway = true
  enable_dns_hostnames = true

  tags = {
    Name        = "jenkins-my-vpc"
    Terraform   = "true"
    Environment = "dev"
  }

  public_subnet_tags = {
    Name = "Jenkins-public-subnet"
  }

}

#SG
module "sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkins-sg"
  description = "Security group for jenkins server "
  vpc_id      = module.vpc.vpc_id


  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "Http for jenkins"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound traffic"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    Name = "jenkins-sg"
  }
}


#EC2
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins-instance"

  //ami = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = "grafana"
  monitoring                  = true
  vpc_security_group_ids      = [module.sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  user_data                   = file("user-data.sh")

  // availability_zone           = data.aws_availability_zone.azs[0].name
  availability_zone = data.aws_availability_zone.azs.name
 
  tags = {
    Name        = "jenkins-server"
    Terraform   = "true"
    Environment = "dev"
  }
}
