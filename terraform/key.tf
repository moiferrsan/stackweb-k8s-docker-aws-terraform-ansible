//Criação de chave SSH para acesso as EC2s
resource "aws_key_pair" "key-web" {
  key_name   = "key-web"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}
