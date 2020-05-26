FROM codercom/code-server:latest

RUN sudo apt-get update && sudo apt-get install -y gnupg2
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | \
    sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
    sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add -
RUN sudo apt update -y
RUN sudo apt-get install google-cloud-sdk -y
RUN sudo apt -y install python3-pip
RUN sudo apt -y install wget
RUN sudo apt -y install gettext
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