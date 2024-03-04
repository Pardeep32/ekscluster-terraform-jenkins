#VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-my-vpc"
  cidr = var.vpc_cidr 

  azs = data.aws_availability_zones.azs.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
 
  // enable_vpn_gateway = true
  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true

  tags = {
    "kubernetes.io/clusters/my-eks-clusters" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/clusters/my-eks-clusters" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/clusters/my-eks-clusters" = "shared"
    "kubernetes.io/role/internal-elb"        = "1"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "my-eks-clusters"
  cluster_version = "1.24"

  cluster_endpoint_public_access = true
  /*
  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }
*/

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets // deploy VPC in private subnet
  // control_plane_subnet_ids = ["subnet-xyzde987", "subnet-slkjf456", "subnet-qeiru789"]

  # EKS Managed Node Group(s)
  /*  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }
  */

  eks_managed_node_groups = {
    nodes = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t2.micro"]
      // capacity_type  = "SPOT"
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
    enable_cluster_creator_admin_permissions = true
    
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
