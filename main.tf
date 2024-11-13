module "eks-kubeconfig" {
  source  = "hyperbadger/eks-kubeconfig/aws"
  version = "1.0.0"

  depends_on = [module.eks]
  cluster_id = module.eks.cluster_id
}

resource "local_file" "kubeconfig" {
  content  = module.eks-kubeconfig.kubeconfig
  filename = "kubeconfig_${local.cluster_name}"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.30.3"

  cluster_name    = local.cluster_name
  cluster_version = "1.24"
  tags = {
    project   = "Kubernetes"
    ManagedBy = "Terraform"
  }

  subnet_ids      = [module.maximumpigs_fabric.subnet_ap-southeast-2a_private_cidr_block,  module.maximumpigs_fabric.subnet_ap-southeast-2b_private_cidr_block, module.maximumpigs_fabric.subnet_ap-southeast-2c_private_cidr_block]

  cluster_endpoint_public_access = true
  cluster_endpoint_public_access_cidrs = [ "${data.http.myip.response_body}/32" ]

  vpc_id = module.maximumpigs_fabric.vpc_id

  eks_managed_node_groups = {
    first = {
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1

      instance_type = "t3.nano"
    }
  }
}