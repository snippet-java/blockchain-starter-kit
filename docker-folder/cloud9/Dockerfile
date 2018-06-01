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

# install maven
ARG MAVEN_VERSION=3.5.3
ARG USER_HOME_DIR="/root"
ARG SHA=b52956373fab1dd4277926507ab189fb797b3bc51a2a267a193c931fffad8408
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha256sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

# install wsk
RUN wget -O wsk.tgz 'https://github.com/apache/incubator-openwhisk-cli/releases/download/latest/OpenWhisk_CLI-latest-linux-amd64.tgz' && \
    tar -C /usr/bin -xvzf wsk.tgz && \
    rm wsk.tgz

# install bx wsk
RUN bx plugin install Cloud-Functions -r Bluemix

EXPOSE 80

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
