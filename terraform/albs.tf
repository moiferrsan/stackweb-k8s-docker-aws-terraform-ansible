//Criação do ALB para balanceamento de carga entre os servidores web
resource "aws_lb" "alb-web" {
  name               = "alb-web"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [
                       "${aws_security_group.allow_http.id}",
                       "${aws_vpc.corp.default_security_group_id}"
                       ]
  subnets            = "${aws_subnet.public.*.id}"

  enable_deletion_protection = false

  tags = {
    Environment = "app-web"
  }
}

//criação do Target Group que será anexado ao ALB e as EC2s
resource "aws_lb_target_group" "tg-web" {
  name     = "tg-web"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.corp.id}"
  
}
//Criação de listener para comunicação HTTP
resource "aws_lb_listener" "lbl-web" {
  load_balancer_arn = "${aws_lb.alb-web.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.tg-web.arn}"
  }
}

//vinculação do target group a instana k8s Master
resource "aws_lb_target_group_attachment" "master" {
  target_group_arn = "${aws_lb_target_group.tg-web.arn}"
  target_id        = "${aws_instance.server-master.id}"
  port             = 30000
}
//vinculação do target group a instana k8s node1
resource "aws_lb_target_group_attachment" "node1" {
  target_group_arn = "${aws_lb_target_group.tg-web.arn}"
  target_id        = "${aws_instance.server-node1.id}"
  port             = 30000
}
//vinculação do target group a instana k8s node2
resource "aws_lb_target_group_attachment" "node2" {
  target_group_arn = "${aws_lb_target_group.tg-web.arn}"
  target_id        = "${aws_instance.server-node2.id}"
  port             = 30000
}
//Mostrar o dns do ALB
output "dns_alb" {
  value = "${aws_lb.alb-web.dns_name}"

}
