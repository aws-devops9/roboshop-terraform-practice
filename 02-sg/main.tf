module "openvpn" {
  source = "../../terraform-aws-sg-module-practice"
  sg_name = "openvpn-sg"
  sg_description = "Security Group for openvpn sg"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_vpc.default_vpc_id.id # whenever we are giving input from ssm parameter we have to mention .value
  
}

module "mongodb" {
  source = "../../terraform-aws-sg-module-practice"
  sg_name = "mongodb-sg"
  sg_description = "Security Group for mongodb sg"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value # whenever we are giving input from ssm parameter we have to mention .value
  
}

module "mysql" {
  source = "../../terraform-aws-sg-module-practice"
  sg_name = "mysql-sg"
  sg_description = "Security Group for mysql sg"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value # whenever we are giving input from ssm parameter we have to mention .value
  
}


module "redis" {
  source = "../../terraform-aws-sg-module-practice"
  sg_name = "redis-sg"
  sg_description = "Security Group for redis sg"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value # whenever we are giving input from ssm parameter we have to mention .value
  
}

module "rabbitmq" {
  source = "../../terraform-aws-sg-module-practice"
  sg_name = "rabbitmq-sg"
  sg_description = "Security Group for rabbitmq sg"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value # whenever we are giving input from ssm parameter we have to mention .value
  
}

module "catalogue" {
  source = "../../terraform-aws-sg-module-practice"
  sg_name = "catalogue-sg"
  sg_description = "Security Group for catalogue sg"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value # whenever we are giving input from ssm parameter we have to mention .value
  
}

module "user" {
  source = "../../terraform-aws-sg-module-practice"
  sg_name = "user-sg"
  sg_description = "Security Group for user sg"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value # whenever we are giving input from ssm parameter we have to mention .value
  
}

module "cart" {
  source = "../../terraform-aws-sg-module-practice"
  sg_name = "cart-sg"
  sg_description = "Security Group for cart sg"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value # whenever we are giving input from ssm parameter we have to mention .value
  
}

module "shipping" {
  source = "../../terraform-aws-sg-module-practice"
  sg_name = "shipping-sg"
  sg_description = "Security Group for shipping sg"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value # whenever we are giving input from ssm parameter we have to mention .value
  
}

module "payment" {
  source = "../../terraform-aws-sg-module-practice"
  sg_name = "payment-sg"
  sg_description = "Security Group for payment sg"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value # whenever we are giving input from ssm parameter we have to mention .value
  
}

module "web" {
  source = "../../terraform-aws-sg-module-practice"
  sg_name = "web-sg"
  sg_description = "Security Group for web sg"
  project_name = var.project_name
  environment = var.environment
  vpc_id = data.aws_ssm_parameter.vpc_id.value # whenever we are giving input from ssm parameter we have to mention .value
  
}


# openvpn is accepting connections from home
resource "aws_security_group_rule" "openvpn-home" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.openvpn.sg_id
}

# mongodb_sg is accepting connections from openvpn
resource "aws_security_group_rule" "mongodb_openvpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id
  security_group_id = module.mongodb.sg_id

}

# mongodb is accepting connections from catalogue
resource "aws_security_group_rule" "mongodb-catalogue" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = module.catalogue.sg_id
  security_group_id = module.mongodb.sg_id
}

# mongodb is accepting connections from user
resource "aws_security_group_rule" "mongodb-user" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id = module.mongodb.sg_id
}

# redis_sg is accepting connections from openvpn
resource "aws_security_group_rule" "redis_openvpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id
  security_group_id = module.redis.sg_id

}

# redis is accepting connections from user
resource "aws_security_group_rule" "redis-user" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id = module.redis.sg_id
}

# redis is accepting connections from cart
resource "aws_security_group_rule" "redis-cart" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  source_security_group_id = module.cart.sg_id
  security_group_id = module.redis.sg_id
}

# mysql is accepting connections from openvpn
resource "aws_security_group_rule" "mysql-openvpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id
  security_group_id = module.mysql.sg_id
}

# mysql is accepting connections from shipping
resource "aws_security_group_rule" "mysql-shipping" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.shipping.sg_id
  security_group_id = module.mysql.sg_id
}

# rabbitmq is accepting connections from openvpn
resource "aws_security_group_rule" "rabbitmq-openvpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.shipping.sg_id
  security_group_id = module.rabbitmq.sg_id
}

# rabbitmq is accepting connections from payment
resource "aws_security_group_rule" "rabbitmq-payment" {
  type              = "ingress"
  from_port         = 5672
  to_port           = 5672
  protocol          = "tcp"
  source_security_group_id = module.payment.sg_id
  security_group_id = module.rabbitmq.sg_id
}

# catalogue is accepting connections from openvpn
resource "aws_security_group_rule" "catalogue-openvpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id
  security_group_id = module.catalogue.sg_id
}

# catalogue is accepting connections from web
resource "aws_security_group_rule" "catalogue-web" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.web.sg_id
  security_group_id = module.catalogue.sg_id
}

# catalogue is accepting connections from cart
resource "aws_security_group_rule" "catalogue-cart" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.cart.sg_id
  security_group_id = module.catalogue.sg_id
}

# user is accepting connections from openvpn
resource "aws_security_group_rule" "user-openvpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id
  security_group_id = module.user.sg_id
}

# user is accepting connections from web
resource "aws_security_group_rule" "user-web" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.web.sg_id
  security_group_id = module.user.sg_id
}

# user is accepting connections from payment
resource "aws_security_group_rule" "user-payment" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.payment.sg_id
  security_group_id = module.user.sg_id
}

# cart is accepting connections from openvpn
resource "aws_security_group_rule" "cart-openvpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id
  security_group_id = module.cart.sg_id
}

# cart is accepting connections from web
resource "aws_security_group_rule" "cart-web" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.web.sg_id
  security_group_id = module.cart.sg_id
}
# cart is accepting connections from shipping
resource "aws_security_group_rule" "cart-shipping" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.shipping.sg_id
  security_group_id = module.cart.sg_id
}
# cart is accepting connections from payment
resource "aws_security_group_rule" "cart-payment" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.payment.sg_id
  security_group_id = module.cart.sg_id
}

# shipping is accepting connections from openvpn
resource "aws_security_group_rule" "shipping-openvpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id
  security_group_id = module.shipping.sg_id
}

# shipping is accepting connections from web
resource "aws_security_group_rule" "shipping-web" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.web.sg_id
  security_group_id = module.shipping.sg_id
}

# payment is accepting connections from openvpn
resource "aws_security_group_rule" "payment-openvpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id
  security_group_id = module.payment.sg_id
}

# payment is accepting connections from web
resource "aws_security_group_rule" "payment-web" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.web.sg_id
  security_group_id = module.payment.sg_id
}

# web is accepting connections from openvpn
resource "aws_security_group_rule" "web-openvpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.openvpn.sg_id
  security_group_id = module.web.sg_id
}

# web is accepting connections from internet
resource "aws_security_group_rule" "web-internet" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.web.sg_id
}













