
resource "aws_instance" "myapp-server" {
  count                       = local.count
  ami                         = data.aws_ami.latest-amazon-linux-image.id
  instance_type               = var.instance_type
  key_name                    = local.key_name
  subnet_id                   = aws_subnet.myapp-subnet[count.index].id
  availability_zone           = var.availability_zone[count.index]
  vpc_security_group_ids      = [ aws_default_security_group.default-sg.id ]
  associate_public_ip_address = true
  user_data                   = file("jenkins-server-script.sh")
  tags                        = {
    Name                      = format("%s-%d", local.env_prefix, count.index)
  }
}