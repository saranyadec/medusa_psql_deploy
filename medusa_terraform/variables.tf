variable "kbt_vpc_dev" {
    default = "vpc-004360fc01cbcbc29"
}

variable "region" {
    default = "ap-south-1"
}

# variable "image_id" {
#     #default = "ami-0df7a53affdc7cb92"
#     default = "ami-0c8892ce5874c1780"
# }

# variable "instance_type" {
#     default = "t3.medium"
# }

# variable "key_name" {
#     default = "kbt-microservices"
# }

variable "cluster_name" {
    default = "pvt-cluster-test"
}

# variable "volume_size" {
#     default = 30
# }

# variable "volume_type" {
#     default = "gp2"
# }

variable "load_balancer_type" {
    default = "application"
}

# variable "desired_capacity" {
#     default = 1
# }    

# variable "min_size" {
#     default = 1
# }  

# variable "max_size" {
#     default = 1
# }  

variable "health_check_grace_period" {
    default = 300
} 

variable "health_check_type" {
    default = "EC2"
} 

variable "target_type" {
    default = "instance"
}

variable "healthy_threshold" {
    default = "10"
}

variable "healthy_interval" {
    default = "300"
}

variable "healthy_protocol" {
    default = "HTTP"
}

variable "healthy_matcher" {
    default = "200"
}

variable "healthy_timeout" {
    default = "120"
}

variable "unhealthy_threshold" {
    default = "10"
}

variable "tg_port" {
    default = 80
}

variable "tg_protocol" {
    default = "HTTP"
}

# variable "ssl_policy" {
#     default = "ELBSecurityPolicy-2016-08"
# }

# variable "certificate_arn" {
#     default = "arn:aws:acm:ap-south-1:948930947331:certificate/b2ab6c06-f3d4-4658-9dee-172b28b86e8e"
# }

# variable "zone_id" {
#     default = "Z0221120RSG766W3M095"
# }

variable "task_memory" {
    default = 512
}

variable "task_cpu" {
    default = 256
}

variable "RDS_PASSWORD" {
    default = "kbtrdspswd5200"
}

variable "network_mode" {
    default = "bridge"
}

variable "launch_type" {
    default = "EC2"
} 

variable "scheduling_strategy" {
    default = "REPLICA"
} 

variable "task_count" {
    default = 1
}  

# variable "KB_CLIENT_SECRET" {
#     default = "tTszAkeHkFZIIPjiM5z1tGotBUROgS4C"
# }

variable "listener_arn" {
  type    = string
  default = "arn:aws:elasticloadbalancing:ap-south-1:948930947331:listener/app/kbt-ptivate-alb/a5f693e97598a45e/0e8c70158ff0296c"
}

variable "lb_name" {
  type    = string
  default = "kbt-ptivate-alb"
}