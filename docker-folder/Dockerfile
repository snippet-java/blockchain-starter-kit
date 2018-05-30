FROM kdelfour/cloud9-docker

#Install Java
RUN apt-get update \
    && apt-get -y install wget \
    && apt-get -y -f install default-jdk

# Install Go-lang 
RUN wget -O golang.tgz 'https://dl.google.com/go/go1.10.2.linux-amd64.tar.gz' \
    && tar -C /usr/local -xvzf golang.tgz \
    && rm golang.tgz 

ENV PATH="${PATH}:/usr/local/go/bin"

# install CF
RUN wget -O cf.tgz 'https://cli.run.pivotal.io/stable?release=linux64-binary&source=github' && \
    tar -C /usr/bin -xvzf cf.tgz && \
    rm cf.tgz

# install BX CF
RUN wget -O bxcf.tgz 'https://clis.ng.bluemix.net/download/bluemix-cli/0.6.7/linux64' && \
    tar -C /usr/local -xvzf bxcf.tgz && \
    rm bxcf.tgz && \
    /usr/local/Bluemix_CLI/install_bluemix_cli

# install git
RUN apt-get install --yes git

EXPOSE 80

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]