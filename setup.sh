#!/bin/bash

echo "Navegar até a pasta do Terraform"
echo "#######################################################"
cd terraform/

echo "Inicializar o Terraform com os recursos da AWS Provider"
echo "#######################################################"
terraform init

echo "Criar os recursos"
echo #######################################################
terraform apply -auto-approve

echo "Setar os ips no arquivo de hosts do Ansible e o DNS do ALB no arquivo de criação dos ingress"
echo "#######################################################"
sed -i "s/ip_publico_master/$(terraform output ip_publico_master)/g" ../ansible/k8s/hosts
sed -i "s/ip_publico_node1/$(terraform output ip_publico_node1)/g" ../ansible/k8s/hosts
sed -i "s/ip_publico_node2/$(terraform output ip_publico_node2)/g" ../ansible/k8s/hosts
sed -i "s/ip_privado_master/$(terraform output ip_privado_master)/g" ../ansible/k8s/hosts
sed -i "s/dns_alb/$(terraform output dns_alb)/g" ../ansible/k8s/roles/deploy-app/files/ingress-rules.yaml

echo "Navegar até pasta do playbook"
echo "#######################################################"
cd ../ansible/k8s/

echo "Executar o playbook para instalação do K8S e deploy da aplicação"
echo "#######################################################"
ansible-playbook -i hosts main.yml

echo "Testar a aplicação via CURL"
echo "#######################################################"
apt-get install curl -y
cd ../../terraform/
curl $(terraform output dns_alb)
curl $(terraform output dns_alb)/backend

