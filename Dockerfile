FROM library/alpine:3.5

RUN \
  apk add --upgrade --no-cache \
    git \
    curl \
    ca-certificates \
    linux-headers \
    openssl \
    openssl-dev \
    openssh-client \
    openssh \
    python \
    python-dev \
    py-pip \
    py-boto \
    build-base \
    py-setuptools \
    libffi-dev \
    tar
RUN \
  pip install --upgrade pip boto boto3 awscli ansible==2.2.2.0 && \
  rm -rf /var/cache/apk/*

RUN wget https://storage.googleapis.com/kubernetes-release/release/v1.6.1/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl && chmod u+x /usr/local/bin/kubectl
RUN wget https://github.com/kubernetes/kops/releases/download/1.5.3/kops-linux-amd64 -O /usr/local/bin/kops && chmod u+x /usr/local/bin/kops

RUN mkdir /etc/ansible/ /ansible
RUN echo "[local]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/hosts

RUN mkdir ~/.aws
RUN mkdir -p /ansible/playbooks
WORKDIR /ansible/playbooks

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PATH /ansible/bin:$PATH
ENV PYTHONPATH /ansible/lib

ENTRYPOINT ["ansible-playbook"]
