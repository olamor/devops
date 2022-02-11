provider "aws" {
  region     = "us-east-1"
  access_key = "XXXXXXXXXXXXXXXXXXXXXXXX"
  secret_key = "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY"
}

resource "aws_instance" "my_openfire" {
  ami = "ami-04505e74c0741db8d"              #Ubuntu AMI
  instance_type = "t2.micro"
  key_name   = "keyopenfire"
  vpc_security_group_ids = [aws_security_group.openfire_ports.id]
  #user_data = file("ofpsql/ofpsql.sh")

    connection {    
      type     = "ssh"    
      user     = "ubuntu"    
      private_key = file("/home/topadmin/Softserve/keyopenfire.pem")
      host     = self.public_ip  
    }

  provisioner "file" {    
    source      = "openfire.sh"    
    destination = "/tmp/openfire.sh"  
  }

  provisioner "remote-exec" {    
    inline = [      
      "chmod +x /tmp/openfire.sh",      
      "sudo /tmp/openfire.sh",    
    ]  
  }

  tags = {
    Name = "openfire"
  }

}

resource "aws_instance" "promgraf" {
  ami = "ami-04505e74c0741db8d"              #Ubuntu AMI
  instance_type = "t2.micro"
  key_name   = "keyopenfire"
  vpc_security_group_ids = [aws_security_group.promgraf_ports.id]
  #user_data = file("jenpromgraf/jenpromgraf.sh")

      connection {    
      type     = "ssh"    
      user     = "ubuntu"    
      private_key = file("/home/topadmin/Softserve/keyopenfire.pem")
      host     = self.public_ip  
    }

  provisioner "file" {    
    source      = "prometheus.sh"    
    destination = "/tmp/prometheus.sh"  
  }

  provisioner "remote-exec" {    
    inline = [      
      "chmod +x /tmp/prometheus.sh",      
      "sudo /tmp/prometheus.sh",    
    ]  
  }

  tags = {
    Name = "promgraf"
  }

}

resource "aws_security_group" "openfire_ports" {
  name        = "allow_ports"
  description = "Allow ports inbound traffic"

  ingress {
    description      = "Open port 9090 for Openfire"
    from_port        = 9090
    to_port          = 9090
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  ingress {
    description      = "Open port 5222 for Openfire"
    from_port        = 5222
    to_port          = 5222
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Open port 7777 for Openfire"
    from_port        = 7777
    to_port          = 7777
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Open port 5432 for PostgreSQL"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Open port 9100 for NodeExporter"
    from_port        = 9100
    to_port          = 9100
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Open port 22 for SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ports_for_openfire"
  }
}



resource "aws_security_group" "promgraf_ports" {
  name        = "allow_ports2"
  description = "Allow ports inbound traffic"

  ingress {
    description      = "Open port for SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Open port for Jenkins"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Open port 9090"
    from_port        = 9090
    to_port          = 9090
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Open port 3030 for Grafana"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ports_for_promgraf"
  }
}
