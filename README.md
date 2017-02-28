# vayu-ansible-client

[![CircleCI](https://circleci.com/gh/vayuadm/vayu-ansible-client.svg?style=svg)](https://circleci.com/gh/vayuadm/vayu-ansible-client)

A dockerfile for creating an Alpine based image with Ansible, AWS-CLI, kops & k8s

## Usage
```shell

$ docker run -d -v [ANSIBLE_PROJECT_PATH]:/ansible/playbooks -v [AWS_CREDENTIALS_PATH]:/root/.aws vayuadm/vayu-ansible-client [PLAYBOOK_YAML_FILE_TO_RUN] [ANSIBLE ARGS]

```
