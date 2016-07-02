variable "access_key" {}
variable "secret_key" {}

provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "ap-northeast-1"
}

resource "aws_instance" "solr1" {
    ami = "ami-6154bb00"
    key_name = "hirosue"
    instance_type = "t2.micro"
    vpc_security_group_ids = [
        "${aws_security_group.allow_local.id}"
    ]
    private_ip = "172.31.18.161"
}

resource "aws_instance" "solr2" {
    ami = "ami-6154bb00"
    key_name = "hirosue"
    instance_type = "t2.micro"
    vpc_security_group_ids = [
        "${aws_security_group.allow_local.id}"
    ]
    private_ip = "172.31.18.162"
}

resource "aws_security_group" "allow_local" {
    name = "allow_local"
    description = "Allow Only Local traffic"
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["153.156.43.75/32","172.31.0.0/16"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}