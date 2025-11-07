# Terraform Pratice 
''''
resource "aws_security_group" "sg" {
  vpc_id = "vpc-058f6b136e670fa3c"
  name = "firewall-b60-tf"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
ingress {
    from_port = 80
    to_port = 80
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_instance" "vm" {
    ami = "ami-0305d3d91b9f22e84"
    instance_type = "t3.micro"
    key_name = "Private-Key"
    vpc_security_group_ids = [aws_security_group.sg.id]
    user_data = <<-EOF
     #!/bin/bash 
     sudo -i 
     yum install httpd -y 
     systemctl start httpd 
     systemctl enable httpd 
     echo "Hello Terraform" > /var/www/html/index.html
    EOF
    tags = {
        Name = "WebServer"
    }
}
''''





