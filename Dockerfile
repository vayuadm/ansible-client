FROM library/alpine:3.5

RUN \
  apk add --upgrade --no-cache \
    git \
    curl \
    linux-headers \
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
  pip install --upgrade pip boto awscli ansible && \
  rm -rf /var/cache/apk/*

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

#ENTRYPOINT ["ansible-playbook"]
