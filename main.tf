
provider "aws" {
  region = var.region
}

resource "aws_db_instance" "my_database" {
  allocated_storage       = 5
  storage_type            = "gp2"
  engine                  = "postgres"
  engine_version          = "12.3"
  instance_class          = "db.t2.micro"
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  parameter_group_name    = "default.postgres12"
  backup_retention_period = 0
}

resource "aws_iam_role" "beanstalk_service" {
  name = "beanstalk_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "beanstalk_log_attach" {
  role       = aws_iam_role.beanstalk_service.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_instance_profile" "beanstalk_iam_instance_profile" {
  name = "beanstalk_iam_instance_profile"
  role = aws_iam_role.beanstalk_service.name
}

resource "aws_s3_bucket" "my_app_ebs" {
  bucket = "my-app-ebs-sample2022"
  force_destroy = true

  tags = {
    name = "My APP EBS"
  }
}

resource "aws_s3_bucket_acl" "my_app_deployment" {
  # bucket = "${aws_s3_bucket.my_app_ebs.bucket}"
  bucket = aws_s3_bucket.my_app_ebs.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "my_app_deployment" {
  # bucket = "${aws_s3_bucket.my_app_ebs.bucket}"
  bucket = aws_s3_bucket.my_app_ebs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "my_app_deployment" {
  # bucket = "${aws_s3_bucket.my_app_ebs.id}"
  bucket = aws_s3_bucket.my_app_ebs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "my_app_deployment" {
  bucket = aws_s3_bucket.my_app_ebs.id
  key    = "Dockerrun.aws.json"
  source = "Dockerrun.aws.json"
}

resource "aws_elastic_beanstalk_application" "my_app" {
  name        = "my-app-dev"
  description = "My wonderful app"
}

resource "aws_elastic_beanstalk_environment" "dev_env" {
  name         = "my-app-dev-env"
  application  = aws_elastic_beanstalk_application.my_app.name
  cname_prefix = "my-app"

  solution_stack_name = "64bit Amazon Linux 2 v3.1.2 running Docker"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.beanstalk_iam_instance_profile.arn
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "StreamLogs"
    value     = "True"
  }

  dynamic "setting" {
    for_each = local.app_env
    content {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = setting.key
      value     = setting.value
    }
  }
}

resource "aws_elastic_beanstalk_application_version" "my_app_ebs_version" {
  name        = "my-app-ebs-version"
  application = aws_elastic_beanstalk_application.my_app.name
  description = "application version created by terraform"
  bucket      = aws_s3_bucket.my_app_ebs.id
  key         = aws_s3_object.my_app_deployment.id
}


