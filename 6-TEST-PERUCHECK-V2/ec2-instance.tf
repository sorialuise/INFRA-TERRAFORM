resource "aws_instance" "project01" {
    ami = var.ami_id
    instance_type = var.instance_type      
    associate_public_ip_address = true
    subnet_id = var.subnet1
    #vpc_security_group_ids = [var.security_group]
    vpc_security_group_ids = [aws_security_group.sg-project01.id]
    key_name = var.key
    iam_instance_profile = var.role

  
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

resource "aws_ebs_volume" "project01" {
  availability_zone = var.zone 
  size              = var.vol_ebs1_size
  encrypted         = true
  
  tags = {
    Name = "${var.project_name}-${var.environment}"
  }
}

resource "aws_volume_attachment" "ebs_project01" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.project01.id
  instance_id = aws_instance.project01.id
}
