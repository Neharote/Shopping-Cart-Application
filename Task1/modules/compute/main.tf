resource "aws_instance" "jenkins" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet_ids[0]
  vpc_security_group_ids = [var.jenkins_sg_id]
  key_name               = var.key_name
  iam_instance_profile   = var.instance_profile

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install java-openjdk11 -y
              yum install jenkins -y
              systemctl enable jenkins
              systemctl start jenkins
              EOF

  tags = {
    Name = "Jenkins-Master"
  }
}