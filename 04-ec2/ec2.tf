
module "mongodb" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "mongodb"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.mongodb_sg_id.value] # we have to insert database security group here
  subnet_id              = local.database_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-mongodb"
    }
  ) 
}

module "redis" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "redis"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.redis_sg_id.value] # we have to insert database security group here
  subnet_id              = local.database_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-redis"
    }
  ) 
}


module "mysql" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "mysql"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.mysql_sg_id.value] # we have to insert database security group here
  subnet_id              = local.database_subnet_id

  tags = merge(
    var.common_tags,
     {
        Name = "${var.project_name}-${var.environment}-mysql"
    }
  ) 
}

module "rabbitmq" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "rabbitmq"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.rabbitmq_sg_id.value] # we have to insert database security group here
  subnet_id              = local.database_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-rabbitmq"
    }
  ) 
}

module "catalogue" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "catalogue"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.catalogue_sg_id.value] # we have to insert database security group here
  subnet_id              = local.private_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-catalogue"
    }
  ) 
}

module "user" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "user"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.user_sg_id.value] # we have to insert database security group here
  subnet_id              = local.private_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-user"
    }
  ) 
}

module "cart" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "cart"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.cart_sg_id.value] # we have to insert database security group here
  subnet_id              = local.private_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-cart"
    }
  ) 
}

module "shipping" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "shipping"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.shipping_sg_id.value] # we have to insert database security group here
  subnet_id              = local.private_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-shipping"
    }
  ) 
}

module "payment" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "payment"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.payment_sg_id.value] # we have to insert database security group here
  subnet_id              = local.private_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-payment"
    }
  ) 
}

module "web" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "web"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.web_sg_id.value] # we have to insert database security group here
  subnet_id              = local.private_subnet_id

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-web"
    }
  ) 
}

module "ansible" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "ansible"

  instance_type          = "t3.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.openvpn_sg_id.value] # we have to insert database security group here
  subnet_id              = data.aws_subnet.default_vpc_subnet.id
  user_data = file("ec2-provision.sh")

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-ansible"
    }
  ) 
}


module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  zone_name = "learndevops.space"

  records = [
    {
      name    = "mongodb"
      type    = "A"
      ttl     = 1
      records = [
        "${module.mongodb.private_ip}",
      ]
    },
    {
      name    = "redis"
      type    = "A"
      ttl     = 1
      records = [
        "${module.redis.private_ip}",
      ]
    },
    {
      name    = "mysql"
      type    = "A"
      ttl     = 1
      records = [
        "${module.mysql.private_ip}",
      ]
    },
    {
      name    = "rabbitmq"
      type    = "A"
      ttl     = 1
      records = [
        "${module.rabbitmq.private_ip}",
      ]
    },
    {
      name    = "catalogue"
      type    = "A"
      ttl     = 1
      records = [
        "${module.catalogue.private_ip}",
      ]
    },
    {
      name    = "user"
      type    = "A"
      ttl     = 1
      records = [
        "${module.user.private_ip}",
      ]
    },
    {
      name    = "cart"
      type    = "A"
      ttl     = 1
      records = [
        "${module.cart.private_ip}",
      ]
    },
    {
      name    = "shipping"
      type    = "A"
      ttl     = 1
      records = [
        "${module.shipping.private_ip}",
      ]
    },
    {
      name    = "payment"
      type    = "A"
      ttl     = 1
      records = [
        "${module.payment.private_ip}",
      ]
    },
    {
      name    = "web"
      type    = "A"
      ttl     = 1
      records = [
        "${module.web.private_ip}",
      ]
    },    
  ]
}
