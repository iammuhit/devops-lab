# DevOps Lab

## Fundamentals

- Linux Basics
- Editors — Vim, Nano, Emacs
- Git & GitHub
- Programming
  - Shell Scripting
  - Python Scripting
- Networking, Security & Protocols
- Virtualization & Hypervisors

## Servers & Databases

- Web Servers — Apache, Nginx, Tomcat
- Databases
  - SQL — MySQL, MariaDB, PostgreSQL
  - NoSQL — MongoDB, DynamoDB, Redis

## CI / CD

- GitHub Actions
- Jenkins

## Containerization & Orchestration

- [Docker](docker/README.md)
- Kubernetes
  - Helm
  - Kops

## Cloud + Infrastructure

- [AWS](https://github.com/iammuhit/aws-cloud) — Amazon Web Services
<!--
- AWS Lambda — Serverless Compute Service
- AWS CloudFormation — Infrastructure as Code
- AWS CLI — Command Line Interface
-->
- [Ansible](ansible/README.md) — Configuration Management
- [Terraform](https://github.com/iammuhit/terraform) — Infrastructure as Code

## Monitoring & Logging

- Prometheus
- Grafana

## Local Development Environments

- [Conda](conda/README.md)
- [Vagrant](vagrant/README.md)
- [Localstack](localstack/README.md)

<!--
## Build Tools

- Java — Maven, Gradle
- JavaScript — Webpack, NPM
-->

---

# Git - Submodules

```bash
git clone --recurse-submodules <repository> [<directory>]

git submodule add <repository> [<path>]   # Add repository as submodule
git submodule sync --recursive            # Copy new URL to the local config
git submodule update --init --recursive   # Update submodule from the new URL
```
