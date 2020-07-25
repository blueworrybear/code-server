FROM codercom/code-server:latest

RUN sudo apt-get update && sudo apt-get install -y gnupg2
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | \
    sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
    sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add -
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
RUN sudo apt update -y
RUN sudo apt-get install google-cloud-sdk -y
RUN sudo apt -y install python3-pip
RUN sudo pip3 install virtualenv
RUN sudo apt -y install wget
RUN sudo apt -y install gettext
RUN sudo apt -y install nodejs
RUN sudo apt -y install net-tools
RUN sudo apt -y install sqlite3
RUN sudo apt -y install zip
RUN sudo apt -y install docker.io
# Install Golang
RUN sudo wget https://dl.google.com/go/go1.14.3.linux-amd64.tar.gz
RUN sudo tar -xvf go1.14.3.linux-amd64.tar.gz
RUN sudo mv go /usr/local
WORKDIR /usr/bin
RUN sudo wget https://github.com/containous/traefik/releases/download/v2.2.1/traefik_v2.2.1_linux_amd64.tar.gz
RUN sudo tar -zxvf traefik_v2.2.1_linux_amd64.tar.gz
RUN sudo rm -rf traefik_v2.2.1_darwin_amd64.tar.gz
RUN sudo mkdir -p /etc/traefik
COPY traefik.template.toml /etc/traefik/
COPY provider.template.toml /etc/traefik/
WORKDIR /home/coder
COPY boot.sh /usr/bin/
ENTRYPOINT [ "/bin/bash", "/usr/bin/boot.sh" ]
