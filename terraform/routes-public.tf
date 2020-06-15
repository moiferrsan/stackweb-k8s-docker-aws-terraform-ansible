//Criação de rota que será utilizada pelas subnets publicas para comunicação com a internet através do internet Gatway
resource "aws_route" "rt-public" {
  route_table_id         = aws_vpc.corp.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw-corp.id
}
