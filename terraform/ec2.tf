// Cria�ã�o do node Master do k8s
resource "aws_instance" "server-master" {
  ami           = "ami-0bf9ef4c7f3e35044"
  instance_type = "t3a.medium"
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

//Criaçãddo node1 do k8s
resource "aws_instance" "server-node1" {
  ami           = "ami-0bf9ef4c7f3e35044"
  instance_type = "t3a.medium"
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

//Criaçãddo node2 do k8s
resource "aws_instance" "server-node2" {
  ami           = "ami-0bf9ef4c7f3e35044"
  instance_type = "t3a.medium"
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
