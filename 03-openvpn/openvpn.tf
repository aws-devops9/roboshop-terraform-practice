module "openvpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "openvpn"

  instance_type          = "t3.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.openvpn_sg_id.value] # we have to insert database security group here
  subnet_id              = data.aws_subnet.default_vpc_subnet.id
  user_data = file("openvpn.sh")

  tags = merge(
    var.common_tags,
    var.openvpn_tags,
    {
        Name = "${var.project_name}-${var.environment}-openvpn"
    }
  ) 
}