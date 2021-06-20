resource "aws_instance" "gitlab" {
    ami = var.ami_id
    instance_type = var.instance_type      
    associate_public_ip_address = true
    subnet_id = var.subnet1
    #vpc_security_group_ids = [var.security_group]
    vpc_security_group_ids = [aws_security_group.sg-ec2-1.id]
    key_name = var.key

  
    user_data = file("userdata.sh")

    tags = {
      "Name" = "${var.project_name}-${var.environment}"
    }

    root_block_device {
    volume_size           = var.vol_root_size
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true

    tags = {
    Name = "${var.project_name}-${var.environment}"
  }

  }
  
}

resource "aws_ebs_volume" "gitlab" {
  availability_zone = var.zone 
  size              = var.vol_ebs1_size
  encrypted         = true
  
  tags = {
    Name = "${var.project_name}-${var.environment}"
  }
}

resource "aws_volume_attachment" "ebs_gitlab" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.gitlab.id
  instance_id = aws_instance.gitlab.id
}
