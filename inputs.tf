variable "vpc_cidr_block" {
    type = string
    default = "10.10.0.0/16"
}

variable "subnet_cidr_block" {
    type    = string
    default = "10.10.1.0/24"
}

variable "instance_type" {
    type    = string
    default = "t3.medium"
}

variable "availability_zone" {
    type    = list(string)
    default = [ "ap-south-2a", "ap-south-2c" ] 
}

variable "webserver_info" {
    type                        = object({
        count                   = string
        name                    = string
        key_name                = string
        ami_id                  = string
        instance_type           = string
        public_ip_enabled       = bool        
    })
    default                     = {
        count                   = "2"
        name                    = "webservers"
        key_name                = "from_tf"
        ami_id                  = "ami-04a5a6be1fa530f1c"
        instance_type           = "t3.micro"
        public_ip_enabled       = true
    }
}