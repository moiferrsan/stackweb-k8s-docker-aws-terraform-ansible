#Range de ips que serão utilizados pelas subnets
variable "vpc_cidr_block" {
  description = "Range de Ips"
  default     = "172.17.0.0/16"
}
#Contador utilizado para criaçaõ das subnets em diferentes AZs
variable "az_count" {
  default     = "2"
}
