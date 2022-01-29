output "sub2" {
  value = aws_subnet.sub2.id
}

output "sub3" {
  value = aws_subnet.sub3.id
}

output "sub4" {
  value = aws_subnet.sub4.id
}

output "pub_ssh_sg" {
  value = aws_security_group.pub_ssh_sg.id
}

output "pub_http_sg" {
  value = aws_security_group.pub_http_sg.id
}

output "pri_http_sg" {
  value = aws_security_group.pri_http_sg.id
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.http_tg.arn
}

output "alb_dns_name" {
  value = aws_lb.http_alb.dns_name
}