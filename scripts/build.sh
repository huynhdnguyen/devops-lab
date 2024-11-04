#!/bin/bash

set -e
export tag=$(date "+%Y%m%d%H%M%S")
# # Load configuration to ENV
# require yq version >= 4.44.3 

export $(yq e -o=s '.' config.yaml| sed "s/'//g") 
#printenv
# Check if Docker is running
# if ! docker info > /dev/null 2>&1; then
#     echo "Docker is not running. Please start Docker and try again."
#     exit 1
# fi

# # Build backend image
echo "Building app image..."
docker build -t $dockerRegistry_url/$dockerRegistry_username/$appName:$tag -f app/hackathon-starter/Dockerfile app/hackathon-starter/

# # Build jenkins image
# echo "Building app image..."
# docker build -t $dockerRegistry_url/$dockerRegistry_username/jenkins:latest -f docker/Jenkins/jenkins.Dockerfile docker/Jenkins/

# Login to Docker registry
echo "Logging in to Docker registry..."
echo $dockerRegistry_token | docker login $dockerRegistry_url -u $dockerRegistry_username --password-stdin
# Update to secret in chart
encoded_json=$(cat ~/.docker/config.json | base64)
yq e ".data.\".dockerconfigjson\" = \"$encoded_json\"" -i ./kubernetes/hacker-start/templates/secret.yaml

# # Push backend image
echo "Pushing backend image..."
docker push $dockerRegistry_url/$dockerRegistry_username/$appName:$tag 

# Update image to config.yaml file
echo "Uodating image to config.yaml file"
yq e ".kubernetes.deployments.app.image = \"${dockerRegistry_url}/${dockerRegistry_username}/${appName}:${tag}\"" -i config.yaml
 
echo "Build and push completed successfully!"