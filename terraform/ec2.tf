// Cria√√£ßo do node Master do k8s
resource "aws_instance" "server-master" {
  ami           = "ami-0bf9ef4c7f3e35044"
  instance_type = "t3a.small"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  security_groups = [
                     "${aws_security_group.allow_ssh.id}",
                     "${aws_vpc.corp.default_security_group_id}"
                    ]
  key_name = "${aws_key_pair.key-web.key_name}"
  subnet_id = "${aws_subnet.public.0.id}"
  
  tags = {
    Name      = "K8s - Node Master"
    Stack     = "Production"
    SO     = "Debian Stretch"
  }
}

//Cria√ß√£ddo node1 do k8s
resource "aws_instance" "server-node1" {
  ami           = "ami-0bf9ef4c7f3e35044"
  instance_type = "t3a.small"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  security_groups = [
                     "${aws_security_group.allow_ssh.id}",
                     "${aws_vpc.corp.default_security_group_id}"
                    ]

  key_name = "${aws_key_pair.key-web.key_name}"
  subnet_id = "${aws_subnet.public.0.id}"
  
  tags = {
    Name      = "K8s - Node1"
    Stack     = "Production"
    SO     = "Debian Stretch"
  }
}

//Cria√ß√£ddo node2 do k8s
resource "aws_instance" "server-node2" {
  ami           = "ami-0bf9ef4c7f3e35044"
  instance_type = "t3a.small"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  security_groups = [
                     "${aws_security_group.allow_ssh.id}",
                     "${aws_vpc.corp.default_security_group_id}"
                    ]

  key_name = "${aws_key_pair.key-web.key_name}"
  subnet_id = "${aws_subnet.public.1.id}"
  

  tags = {
    Name      = "K8s - Node2"
    Stack     = "Production"
    SO     = "Debian Stretch"
  }
}

//Mostrar o ip p√blico do node master
output "ip_publico_master" {
  value = "${aws_instance.server-master.public_ip}"

}

//Mostrar o ip p√blico do node1
output "ip_publico_node1" {
  value = "${aws_instance.server-node1.public_ip}"

}

//Mostrar o ip p√blico do node2
output "ip_publico_node2" {
  value = "${aws_instance.server-node2.public_ip}"

}

//Mostrar o ip privado do node master
output "ip_privado_master" {
  value = "${aws_instance.server-master.private_ip}"

}
