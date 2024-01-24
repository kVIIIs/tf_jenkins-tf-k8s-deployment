output "ec2_public_ip" {
    value = "${join(",", aws_instance.myapp-server.*.public_ip)}"
}