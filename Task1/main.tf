module "networking" {
  source   = "./modules/networking"
  vpc_cidr = var.vpc_cidr
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
}


module "storage" {
  source      = "./modules/storage"
  bucket_name = "devops-test-artifacts-bucket"
}


module "iam" {
  source    = "./modules/iam"
  role_name = "jenkins-role"
}


module "compute" {
  source = "./modules/compute"

  public_subnet_ids   = module.networking.public_subnet_ids
  private_subnet_ids  = module.networking.private_subnet_ids
  jenkins_sg_id       = module.security.jenkins_sg_id
  app_sg_id           = module.security.app_sg_id
  ami_id              = var.ami_id
  key_name            = var.key_name
  instance_profile    = module.iam.instance_profile_name
}