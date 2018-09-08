FROM ubuntu:trusty

RUN apt-get update && \
      apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      software-properties-common \
      build-essential
RUN apt-add-repository ppa:ansible/ansible
RUN apt-get update

# Python & Ansible
RUN apt-get install -y python-pip python-dev
RUN pip install --upgrade pip
RUN pip install --upgrade virtualenv
RUN pip install -I pip==7.1.2
RUN pip install docker-py
RUN apt-get install -y ansible
ENV ANSIBLE_HOST_KEY_CHECKING=False

# Install Docker for building images
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
RUN apt-add-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get update
RUN apt-get install -y docker-ce

WORKDIR /ansible

RUN ansible-galaxy install --ignore-certs geerlingguy.pip
RUN ansible-galaxy install --ignore-certs geerlingguy.docker

CMD ["bash"]

