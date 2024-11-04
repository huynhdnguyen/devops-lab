#!/bin/bash

set -e

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install packages based on the OS
install_packages() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command_exists apt; then
            sudo apt install gpg apt-transport-https ca-certificates curl gnupg -y
            wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
            gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
            echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

            sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/kubernetes-apt-keyring.gpg
            sudo chmod 644 /etc/apt/kubernetes-apt-keyring.gpg
            
            echo 'deb [signed-by=/etc/apt/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
            sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list
            
            sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/docker.asc
            sudo chmod a+r /etc/apt/docker.asc

            # Add the repository to Apt sources:
            echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/docker.asc] https://download.docker.com/linux/ubuntu \
            $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
            sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
            sudo apt update
                           
            sudo apt install -y containerd.io kubectl

        else
            echo "Unsupported package manager. Please install Docker and kubectl manually."
            exit 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        if command_exists brew; then
            brew install docker kubectl
        else
            echo "Homebrew not found. Please install Homebrew, then run this script again."
            exit 1
        fi
    else
        echo "Unsupported operating system. Please install Docker and kubectl manually."
        exit 1
    fi
}

# Install required packages
echo "Installing required packages..."
install_packages

# Install Minikube
if ! command_exists minikube; then
    echo "Installing Minikube..."
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    rm minikube-linux-amd64
fi

# Start Minikube
echo "Starting Minikube..."
# sudo usermod -aG docker $USER
# newgrp docker
minikube start

# Install Helm
if ! command_exists helm; then
    echo "Installing Helm..."
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
fi

# Install Jenkins
echo "Installing Jenkins..."
helm repo add jenkins https://charts.jenkins.io
helm repo update
#helm install jenkins jenkins/jenkins

# Install Terraform
# if ! command_exists terraform; then
#     echo "Installing Terraform..."
#     curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
#     sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
#     sudo apt-get update && sudo apt-get install terraform
# fi

# # Install AWS CLI
# if ! command_exists aws; then
#     echo "Installing AWS CLI..."
#     curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
#     unzip awscliv2.zip
#     sudo ./aws/install
#     rm -rf aws awscliv2.zip
# fi

echo "Setup completed successfully!"