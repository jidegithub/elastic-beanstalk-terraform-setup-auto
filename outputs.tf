output "ebs_url_endpoint" {
  value       = aws_elastic_beanstalk_environment.dev_env.endpoint_url
  description = "elasticbeanstalk url endpoint"
}