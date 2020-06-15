# Criar duas subnets privadas para cada AZ
resource "aws_subnet" "private" {
#Variável az_count presente no arquivo vars.tf com valor 2
  count             = var.az_count 
#Subnets privadas. Ex: 172.17.[index].0/24
  cidr_block        = cidrsubnet(aws_vpc.corp.cidr_block, 8, count.index) 
#Valores referentes as AZ's da AWS que foram referenciadas no arquivo aws_data.tf. Ex: us-east-[index]
  availability_zone = data.aws_availability_zones.available.names[count.index] 
  vpc_id            = aws_vpc.corp.id

  tags = {
    tipo = "Private"
    Name = "Subnet-Corp-Private-${count.index}"
  }
}

# Criar duas subnets publicas para cada AZ
resource "aws_subnet" "public" {
#Variável az_count presente no arquivo vars.tf com valor 2
  count = var.az_count          
#Subnets pú�blicas. Ex: 172.1[index].0/24
  cidr_block              = cidrsubnet(aws_vpc.corp.cidr_block, 8, var.az_count + count.index) 
#Valores referentes as AZ's da AWS que foram referenciadas no arquivo aws_data.tf. Ex: us-east-1[index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]  
  vpc_id                  = aws_vpc.corp.id
#Defini que todas as inst�ncias criadas nessa subrede teráum ip p�blico atribuido a elas.
  map_public_ip_on_launch = true

  tags = {
    tipo = "Public"
    Name = "Subnet-Corp-Public-${count.index}"
  }
}
