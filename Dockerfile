FROM gliderlabs/alpine:3.3

RUN \
  apk-install \
    git \
    curl \
    openssh-client \
    python \
    py-boto \
    py-dateutil \
    py-httplib2 \
    py-jinja2 \
    py-paramiko \
    py-pip \
    py-setuptools \
    py-yaml \
    libssl-dev \
    libffi-dev \
    python-dev \
    tar && \
  pip install --upgrade pip python-keyczar && \
  rm -rf /var/cache/apk/* && \
  pip install awscli

RUN mkdir /etc/ansible/ /ansible
RUN echo "[local]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/hosts

RUN \
  curl -fsSL https://github.com/ansible/ansible/archive/v2.2.1.0-0.3.rc3.tar.gz -o ansible.tar.gz && \
  tar -xzf ansible.tar.gz -C ansible --strip-components 1 && \
  rm -fr ansible.tar.gz /ansible/docs /ansible/examples /ansible/packaging
RUN \
  pip install git+https://github.com/ansible/ansible-modules-core.git

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