#!/bin/bash
export JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Start Jenkins
tini -- /usr/local/bin/jenkins.sh &

# Đợi Jenkins khởi động
while [ ! -f /var/jenkins_home/jenkins.install.InstallUtil.lastExecVersion ]; do
    sleep 5
    echo "Jenkins server is starting ..."
done


# NEW_PASSWORD="123123"
# echo "jenkins.model.Jenkins.instance.securityRealm.createAccount(\"admin\", \"$NEW_PASSWORD\")" | java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -s http://localhost:8080/ groovy =


# sed -i "s/password=.*/password=$NEW_PASSWORD/" /var/jenkins_home/job_builder_config/jenkins_jobs.ini

# Run Jenkins Job Builder
jenkins-jobs --conf /var/jenkins_home/job_builder_config/jenkins_jobs.ini update /var/jenkins_home/job_builder_config/job_config.yaml
service docker start
wait