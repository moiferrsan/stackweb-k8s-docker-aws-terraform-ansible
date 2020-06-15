// Criação de rotas para internet que serão utilizadas pelos nat gatew
resource "aws_route_table" "rt-private" {
#Contador definido no arquivo vars.tf
  count  = var.az_count
  vpc_id = aws_vpc.corp.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.gw.*.id, count.index)
  }

  tags = {
    Environment = "webapp"
    Name = "rt-private-${count.index}"
  }
}
// associação das rotas privadaas subnets privadas
resource "aws_route_table_association" "private" {
#Contador definido no arquivo vars.tf
  count          = var.az_count
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.rt-private.*.id, count.index)
}
