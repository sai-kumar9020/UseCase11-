resource "aws_security_group" "web_sg" {
  vpc_id = var.vpc_id
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Change to your IP for security
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "WEB-SG" }
}


resource "aws_instance" "nginx_server" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.web_sg.id]
  key_name        =  var.key_name

  tags = { Name = "UseCase-11" }

  user_data = <<-EOF
  #!/bin/bash
  set -e

  # Update and install Nginx
  apt update -y
  apt install -y nginx
  apt-get install -y docker.io
  systemctl start docker
  systemctl enable docker
  usermod -aG docker ubuntu

  # Enable and start Nginx
  systemctl enable nginx
  systemctl start nginx

  # Create custom index.html
  cat <<EOT > /var/www/html/index.html
  <!DOCTYPE html>
  <html>
  <head>
     <title>Welcome to Nginx</title>
  </head>
  <body>
     <h1>Hello from $(hostname)!</h1>
     <p>Nginx is successfully installed on your Ubuntu server.</p>
  </body>
  </html>
  EOT

  # Set ownership and permissions
  chown -R www-data:www-data /var/www/html/
  chmod -R 755 /var/www/html/

  # Restart nginx
  systemctl restart nginx
EOF
}

