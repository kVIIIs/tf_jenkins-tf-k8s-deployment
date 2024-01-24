locals {
    count                = 2
    all_ports            = 0
    ssh_port             = 22
    http_port            = 80
    app_port             = 8080
    db_port              = 3306
    protocol             = "tcp"
    any_protocol         = "-1"
    any_where            = "0.0.0.0/0"
    any_where_ipv6       = "::/0"
    default_desc         = "Created from Terraform"
    key_name             = "jenkins-server"
    env_prefix           = "Jenkins-Master"
    server_tags          = [ "Jenkins-Master", "Jenkins-Agent" ]
}