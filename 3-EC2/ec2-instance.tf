resource "aws_instance" "GitLab" {
    ami = var.ami_id
    instance_type = var.instance_type      
    associate_public_ip_address = true
    subnet_id = var.subnet1_id
    vpc_security_group_ids = [var.security_group]
    key_name = var.key
    

    
    tags = {
      "Name" = var.name_project
    }
  
}