1.Create Personal Access Token (PAT) in GitHub:
- GitHub Settings > Developer settings > Personal access tokens ( with write:packages permission)
- input to config.yaml > dockerRegistry > token

2. Run
```bash
# Get the latest application
git clone https://github.com/sahat/hackathon-starter app/hackathon-starter

# Run setup enviroment
./scripts/setup.sh 

# Run build image
./scripts/build.sh

# Deploy on minikube
./scripts/deploy.sh
```

```code 
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
```