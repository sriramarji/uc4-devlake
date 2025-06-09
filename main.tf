module "vpc" {
  source     = "./modules/vpc" #how to know which values we need to give
  #subnet_ids = module.vpc.subnet_ids
}

module "ec2" {
  source = "./modules/ec2"

  ami_id     = "ami-084568db4383264d4"
  inst_type  = "t2.medium"
  subnet_ids = module.vpc.subnet_ids
  vpc_id     = module.vpc.vpc_id
  key_name   = "Hcl-prac-training"
}

module "alb" {

  source             = "./modules/alb"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.subnet_ids
  ec2_instance_id    = module.ec2.instance_ids # From EC2 module output
  #target_group_a_arn = module.alb.target_group_a_arn
}