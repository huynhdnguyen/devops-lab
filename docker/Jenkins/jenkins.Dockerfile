FROM jenkins/jenkins:lts

# Using root for installing dependencies
USER root
#########################
# install docker
RUN apt-get update && apt-get -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    python3 \
    python3-pip \
    apt-transport-https \
    gnupg-agent 
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update && apt-get -y install docker-ce docker-ce-cli containerd.io
RUN usermod -aG docker jenkins

# install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl; chmod +x ./kubectl; mv ./kubectl /usr/local/bin/kubectl


# Install Jenkins Job Builder
RUN pip3 install jenkins-job-builder --break-system-packages

RUN mkdir -p /var/jenkins_home/job_builder_config

COPY custom-entrypoint.sh /usr/local/bin/custom-entrypoint.sh
RUN chmod +x /usr/local/bin/custom-entrypoint.sh

# USER jenkins


COPY jenkins-plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY jenkins-job-builder.yaml /var/jenkins_home/job_builder_config/job_config.yaml 
COPY jenkins-jobs.ini /var/jenkins_home/job_builder_config/jenkins_jobs.ini

# Install plugins Jenkins
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt


ENTRYPOINT ["/usr/local/bin/custom-entrypoint.sh"]

# Expose Jenkins
EXPOSE 8080