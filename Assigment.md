# DevOps | Home Assignment
## Objective
Implement a fully automated deployment pipeline for a full-stack web application using containerization and orchestration tools. The solution should be portable and adaptable to various environments without requiring manual intervention.

## Project Overview
For this assignment, we will use the hackathon-starter project (https://github.com/sahat/hackathon-starter).
This project provides a boilerplate for building scalable web applications using Node.js, Express, MongoDB,Passport.js, and React.

## Requirements
- Memory: Ensure the setup can run on a machine with at least 4GB of RAM.
- Tools: Container runtime (e.g., Docker), Orchestration platform (e.g., Kubernetes), CI/CD tool (e.g.,Jenkins), Infrastructure-as-Code tool (e.g., Terraform)
- Application: Use the https://github.com/sahat/hackathon-starter repository as described below..

## Assignment Steps
### 1. Environment Setup
- Create a configuration file (config.yaml) to store environment-specific variables.
- Implement a shell script (setup.sh) that:
    - Installs required dependencies based on the target operating system.
    - Sets up the container runtime and orchestration platform.
    - Configures the CI/CD tool.

### 2. Application Modification / Containerization
| BONUS (Optional) |
| :----------------- |
| - Clone the hackathon-starter repository.|
| - Modify the application to add a new feature: a simple blog post system.|
|   - Add routes for creating, reading, updating, and deleting blog posts.|
|   - Implement corresponding database models and controllers.|
|   - Update the frontend to include a page for viewing and managing blog posts.|

- Write Dockerfiles for both frontend and backend services.
- Implement a build script (build.sh) that:
- Builds Docker images for both services.
- Pushes the images to a configurable container registry.

### 3. Orchestration
- Create Kubernetes manifests (YAML files) for deploying the frontend and backend services.
- Include Deployment, Service, and Ingress resources.
- Implement a deployment script (deploy.sh) that:
    - Applies the Kubernetes manifests to deploy the application.
    - Configures ingress rules based on the environment.

### 4. CI/CD Pipeline
- Set up a CI/CD pipeline using the chosen tool (e.g., Jenkins).
- Configure the pipeline to:
    - Pull the latest code from the GitHub repository.
    - Run automated tests (if available). (including the optional blog post feature)
    - Build Docker images for both services.
    - Push the Docker images to the container registry.
    - Apply the Kubernetes manifests to deploy the updated services.

### 5. Documentation
- Provide comprehensive documentation (README.md) including:
    - Setup instructions for different environments.
    - Configuration options and their effects.
    - Troubleshooting guide.
    - Security considerations.

## Evaluation Criteria
1. Portability: The solution should work across different operating systems and cloud providers.
2. Automation: Minimal manual intervention required for setup and deployment.
3. Scalability: Ability to easily scale the application horizontally.
4. Security: Proper security measures implemented in the CI/CD pipeline and deployed application.
5. Code Quality: Clean, well-documented code for all scripts and configurations.
6. Best Practices: Adherence to DevOps best practices for containerization, orchestration, and CI/CD.
7. Functionality: The application should be fully functional and accessible after deployment.
8. Documentation: Clear, concise, and comprehensive documentation.

## Tools for Testing
- Container runtime (e.g., Docker)
- Orchestration platform (e.g., Minikube, Kind)
- CI/CD tool (e.g., Jenkins)
- Infrastructure-as-Code tool (e.g., T erraform)
- Version control system (e.g., Git)

## Bonus Points
- Implement monitoring and logging solutions.
- Add rollback capabilities to the deployment process.
- Integrate with a package manager for dependency management.
- Implement multi-stage builds for optimized Docker images.

## Submission Guidelines
Please submit your solution as a Git repository containing:
1. All scripts and configurations mentioned above
2. A detailed README.md explaining your approach and implementation
3. Any additional documentation or diagrams that illustrate your architecture. Bonus points for a high-level architecture diagram illustrating the deployment of the web app on AWS using EKS,covering key AWS components, networking, and observability tools/services.
4. Your modified version of the hackathon-starter application with the new blog post feature implemented. (optional)

Ensure that your solution can be easily cloned and run by the reviewer without requiring extensive manual setup