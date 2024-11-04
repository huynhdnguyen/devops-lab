Create Personal Access Token (PAT) in GitHub:

GitHub Settings > Developer settings > Personal access tokens ( with write:packages permission)


├── README.md
├── config.yaml
├── docker
│   └── Jenkins
│       ├── configuration-as-code.yaml
│       ├── custom-entrypoint.sh
│       ├── jenkins-job-builder.yaml
│       ├── jenkins-jobs.ini
│       ├── jenkins-plugins.txt
│       └── jenkins.Dockerfile
├── kubernetes
│   ├── hacker-start
│   │   ├── Chart.yaml
│   │   ├── charts
│   │   ├── templates
│   │   └── values.yaml
│   └── jenkins
│       ├── Jenkinsfile
│       └── values.yaml
└── scripts
    ├── build.sh
    ├── deploy.sh
    └── setup.sh