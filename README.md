# Toumoro Ansible Playbook Repository

This private repository contains Ansible playbooks used to by Toumoro team.

## Overview

These playbooks automate tasks such as:

- Installing Docker and dependencies
- Retrieving environment variables from AWS SSM Parameter Store
- Pulling Solr Docker image
- Configuring memory and Solr options
- Mounting EBS volumes
- Starting Solr containers

## Requirements

- Ansible >= 2.10

## 🚀 Usage

### 1. Run playbook against a target host:

```bash
ansible-playbook -i 'i-000000000000' playbooks/docker-deploy.yml
```