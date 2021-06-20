
resource "aws_service_discovery_private_dns_namespace" "jenkins" {
  name        = "jenkins.jenkins.local"
  description = "jenkins"
  vpc         = var.vpc_id
}

resource "aws_service_discovery_service" "jenkins" {
  name = "jenkins"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.jenkins.id

    dns_records {
        ttl  = 10
        type = "A" 
        }      

    dns_records {
        ttl  = 60
        type = "SRV"
      }
    
      
    

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}