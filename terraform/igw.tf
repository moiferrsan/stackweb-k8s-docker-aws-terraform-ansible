//Criação do Internet Gateway para que a VPC corp possa se comunicar com a internet
resource "aws_internet_gateway" "igw-corp" {
  vpc_id = aws_vpc.corp.id

  tags = {
    Name = "igw-corp"
  }
}
