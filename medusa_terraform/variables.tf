

variable "region" {
    default = "ap-south-1"
}



variable "RDS_PASSWORD" {
    default = "root"
}

variable "network_mode" {
    default = "awsvpc"
}

variable "launch_type" {
    default = "FARGATE"
} 

variable "scheduling_strategy" {
    default = "REPLICA"
} 

