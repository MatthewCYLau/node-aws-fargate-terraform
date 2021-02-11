[
  {
    "dnsSearchDomains": null,
    "environmentFiles": null,
    "logConfiguration": null,
    "entryPoint": null,
    "portMappings": [
      {
        "hostPort": 80,
        "protocol": "tcp",
        "containerPort": 80
      }
    ],
    "command": null,
    "linuxParameters": null,
    "cpu": 0,
    "environment": [
      {
        "name": "NODE_ENV",
        "value": "production"
      }
    ],
    "resourceRequirements": null,
    "ulimits": null,
    "dnsServers": null,
    "mountPoints": [],
    "workingDirectory": null,
    "secrets": null,
    "dockerSecurityOptions": null,
    "memory": null,
    "memoryReservation": 512,
    "volumesFrom": [],
    "stopTimeout": null,
    "image": "${aws_ecr_repository}",
    "startTimeout": null,
    "firelensConfiguration": null,
    "dependsOn": null,
    "disableNetworking": null,
    "interactive": null,
    "healthCheck": null,
    "essential": true,
    "links": null,
    "hostname": null,
    "extraHosts": null,
    "pseudoTerminal": null,
    "user": null,
    "readonlyRootFilesystem": null,
    "dockerLabels": null,
    "systemControls": null,
    "privileged": null,
    "name": "node_express_ecs_container"
  }
]
