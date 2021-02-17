[
  {
    "name": "${container_name}",
    "image": "${aws_ecr_repository}:${tag}",
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "us-east-1",
        "awslogs-stream-prefix": "${aws_cloudwatch_log_group_name}-service",
        "awslogs-group": "${aws_cloudwatch_log_group_name}"
      }
    },
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000,
        "protocol": "tcp"
      }
    ],
    "cpu": 1,
    "environment": [
      {
        "name": "NODE_ENV",
        "value": "production"
      },
      {
        "name": "JWT_SECRET",
        "value": "superscretwhichshouldnotbehere"
      },
      {
        "name": "MONGO_USERNAME",
        "value": "${mongo_username}"
      },
      {
        "name": "MONGO_HOST",
        "value": "${mongo_host}"
      },
      {
        "name": "MONGO_DB_NAME",
        "value": "${mongo_database_name}"
      }
    ],
    "secrets": [{
      "name": "MONGO_PASSWORD",
      "valueFrom": "${mongo_password_secret_arn}"
    }],
    "ulimits": [
      {
        "name": "nofile",
        "softLimit": 65536,
        "hardLimit": 65536
      }
    ],
    "mountPoints": [],
    "memory": 2048,
    "volumesFrom": []
  }
]