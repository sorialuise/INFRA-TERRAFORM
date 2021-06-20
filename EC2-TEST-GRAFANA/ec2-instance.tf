resource "aws_instance" "Project" {
    depends_on = [aws_security_group.sg-project]
    ami = var.ami_id
    instance_type = var.instance_type      
    associate_public_ip_address = true
    subnet_id = var.subnet1
    vpc_security_group_ids = [aws_security_group.sg-project.id]
    key_name = var.key
    iam_instance_profile = var.role
          
    user_data = file("userdata.sh")
    
    tags = {
      "Name" = "${var.project_name}-${var.environment}"
    }
  
}