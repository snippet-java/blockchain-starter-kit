FROM node:0.10.38
# FROM node:latest
MAINTAINER Nathan LeClaire <nathan@docker.com>

# Change root password
RUN echo 'root:root' | chpasswd

ADD . /app
WORKDIR /app
RUN npm install
RUN apt-get update
RUN apt-get install -y vim
RUN useradd -d /home/term -m -s /bin/bash term
RUN echo 'term:term' | chpasswd

# install CF
RUN wget -O cf.tgz 'https://cli.run.pivotal.io/stable?release=linux64-binary&source=github' && \
    tar -C /usr/bin -xvzf cf.tgz && \
    rm cf.tgz

# install BX CF
RUN wget -O bxcf.tgz 'https://clis.ng.bluemix.net/download/bluemix-cli/0.6.7/linux64' && \
    tar -xvzf bxcf.tgz && \
    rm bxcf.tgz && \
    Bluemix_CLI/install_bluemix_cli

# install nano
RUN apt-get install --yes nano

# install wsk
RUN wget -O wsk.tgz 'https://github.com/apache/incubator-openwhisk-cli/releases/download/latest/OpenWhisk_CLI-latest-linux-amd64.tgz' && \
    tar -C /usr/bin -xvzf wsk.tgz && \
    rm wsk.tgz

# install bx wsk
RUN bx plugin install Cloud-Functions -r Bluemix

# Install Java
RUN apt-get -y -f install default-jdk

# Install Maven - disable for now as it needs 256M to run properly
# RUN apt-get -y install maven


# Install python
RUN apt-get -y install python3 python3-pip

# Install sqlite
RUN apt-get -y install sqlite3

EXPOSE 80

ENTRYPOINT ["node"]
CMD ["app.js", "-p", "80"]