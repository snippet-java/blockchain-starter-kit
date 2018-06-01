FROM node:0.10.38
MAINTAINER Nathan LeClaire <nathan@docker.com>

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

EXPOSE 80

ENTRYPOINT ["node"]
CMD ["app.js", "-p", "80"]
