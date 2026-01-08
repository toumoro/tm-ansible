# Use an official Ansible image as a parent image
FROM serversideup/ansible:latest

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

# Download and install SSM Agent and Session Manager Plugin for multi-arch
RUN export DEBIAN_FRONTEND=noninteractive && \
    ARCH=$(dpkg --print-architecture) && \
    case $ARCH in \
        amd64) SSM_ARCH="amd64"; SESSION_MANAGER_ARCH="64bit" ;; \
        arm64) SSM_ARCH="arm64"; SESSION_MANAGER_ARCH="arm64" ;; \
        *) echo "Unsupported architecture: $ARCH"; exit 1 ;; \
    esac && \
    wget "https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_${SSM_ARCH}/amazon-ssm-agent.deb" -O amazon-ssm-agent.deb && \
    dpkg -i amazon-ssm-agent.deb && \
    rm amazon-ssm-agent.deb && \
    wget "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_${SESSION_MANAGER_ARCH}/session-manager-plugin.deb" -O session-manager-plugin.deb && \
    dpkg -i session-manager-plugin.deb && \
    rm session-manager-plugin.deb

# Set the working directory
WORKDIR /ansible

# Copy the rest of the application
COPY . /ansible/