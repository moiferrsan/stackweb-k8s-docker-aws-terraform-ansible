#vamos criar uma vpc utilizando-se da vari√vel: vpc_cidr_block que est√° presente no arquivo vars.tf
resource "aws_vpc" "corp" {
  cidr_block           = var.vpc_cidr_block #cidr_block default 172.17.0.0/16
  enable_dns_hostnames = true #habilita resolu√√o de DNS dentro da VPC

  tags = {
    Empresa = "corp"
    Name = "vpc-corp"
  }
}
