output "alb_name" {
  value = data.aws_lb.ecs_lb.dns_name
}

output "cluster_arn" {
  value = data.aws_ecs_cluster.kbt_cluster.arn
}

# output "route53_name_1" {
#   value = aws_route53_record.microservices.name
# }

# output "route53_name_2" {
#   value = aws_route53_record.keycloak.name
# }

# Generated API GW endpoint URL that can be used to access the application running on a private ECS Fargate cluster.
output "apigw_endpoint" {
  value = data.aws_apigatewayv2_api.apigw_http_endpoint.api_endpoint
    description = "API Gateway Endpoint"
}