# Use an official Ansible image as a parent image
FROM --platform=linux/amd64 serversideup/ansible:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    unzip \
    curl && \
    rm -rf /var/lib/apt/lists/*

# Install AWS CLI and Session Manager Plugin
RUN pip install boto3 botocore && \
    ansible-galaxy collection install amazon.aws && \
    ansible-galaxy collection install community.aws --upgrade

# Download and install SSM Agent
RUN wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb && \
    dpkg -i amazon-ssm-agent.deb && \
    rm amazon-ssm-agent.deb

# Download and install Session Manager Plugin
RUN wget https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb && \
    dpkg -i session-manager-plugin.deb && \
    rm session-manager-plugin.deb

# Set the working directory
WORKDIR /ansible

# Copy the rest of the application
COPY . /ansible/