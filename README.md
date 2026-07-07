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

## How to release
| Commit Message Format | Release Type Triggered | Version Change Example |
| :--- | :--- | :--- |
| `fix: fix a bug with the login button` | **Patch Release** | `1.0.0` → `1.0.1` |
| `feat: add a new dashboard view` | **Minor Release** | `1.0.0` → `1.1.0` |
| `feat!: change API response structure`<br>*(Note the `!` or adding `BREAKING CHANGE:` in the footer)* | **Major Release** | `1.0.0` → `2.0.0` |

## Requirements

- Ansible >= 2.10

## 🚀 Usage

### 1. Run playbook against a target host:

```bash
ansible-playbook -i 'i-000000000000' playbooks/docker-deploy.yml
```

### 2. Setup built-in module that gathers facts about remote hosts

```bash
ansible all -i inventory.ini -m setup
```
