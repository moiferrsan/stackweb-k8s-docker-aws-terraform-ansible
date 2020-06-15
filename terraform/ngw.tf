//Cria√ß√£o dos elastic ips que ser√£o atachados aos nat gateways
resource "aws_eip" "eip-privatesubnet" {
# Contador definido no arquivo vars.tf
  count = var.az_count
  vpc   = true

  tags = {
    Environment = "webapp"
    Name = "ei-Corp-${count.index}"
  }
}
//Cria√ß√£o dos Nat Gateways que ser√£o utilizados para que as subnets privadas se comuniquem com a internet
resource "aws_nat_gateway" "gw" {
# Contador definido no arquivo vars.tf
  count         = var.az_count
# Sub-redes p√∫√blas onde ser√o °criads os Nat Gateways
  subnet_id     = element(aws_subnet.public.*.id, count.index)
# Associa√√o entre os Nat Gateways e as sub-redes privadas atrav√s dos Elastic ips
  allocation_id = element(aws_eip.eip-privatesubnet.*.id, count.index)

  tags = {
    Environment = "webapp"
    Name = "ng-Corp-${count.index}"
    
  }
}
