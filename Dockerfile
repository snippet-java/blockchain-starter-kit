FROM dorowu/ubuntu-desktop-lxde-vnc

ARG VSC_DEB_FILE="vsc.deb"

# Install Required Dependencies
RUN apt-get update && \
    apt-get -y upgrade && \
    
    apt-get -y install \
        libcanberra-gtk-module \
        libgconf-2-4 \
        libasound2 \
        libgtk2.0-0 \
        libxss1 && \
    # Force installation of missing dependencies
    apt-get -y -f install && \

    # Install Visual Studio Code
    curl -L 'https://go.microsoft.com/fwlink/?LinkID=760868' -o "${VSC_DEB_FILE}" && \
    dpkg -i -R "${VSC_DEB_FILE}" || echo "\n Will force install of missing Visual Studio Code dependencies...\n" && \

    # Force installation of missing dependencies for Visual Studio Code
    apt-get -y -f install && \
    echo "completed vsc"

# TODO - settle the container persistence issue
# Install VSC extensions (IBM Bluemix tool, json, python) 
# RUN code --install-extension IBM.ibm-developer --user-data-dir="~/vscode-root" && \ 
    # code --install-extension eriklynd.json-tools --user-data-dir="~/vscode-root" && \
    # code --install-extension tht13.python --user-data-dir="~/vscode-root" && \
    # mkdir backup && \
    # cp -R .vscode /root/backup


############

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
    apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer libxext-dev libxrender-dev libxtst-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*
    
# RUN wget http://eclipse.c3sl.ufpr.br/technology/epp/downloads/release/luna/SR2/eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz -O /tmp/eclipse.tar.gz -q && \
#     echo 'Installing eclipse' && \
#     tar -xf /tmp/eclipse.tar.gz -C /opt && \
#     rm /tmp/eclipse.tar.gz && \
#     ls -alh /opt

# ADD run /opt/eclipse/eclipse

# ADD image /

###########

# Install Node.js
RUN apt-get install --yes curl
RUN curl --silent --location https://deb.nodesource.com/setup_9.x | sudo bash -
RUN apt-get install --yes nodejs
RUN apt-get install --yes build-essential

# Bundle app source
# Trouble with COPY http://stackoverflow.com/a/30405787/2926832
#COPY . /src

# Install app dependencies
#RUN cd /src; npm install


###########

# install CF
RUN wget -O cf.tgz 'https://cli.run.pivotal.io/stable?release=linux64-binary&source=github' && \
    tar -xvzf cf.tgz && \
    rm cf.tgz

# install BX CF
RUN wget -O bxcf.tgz 'https://clis.ng.bluemix.net/download/bluemix-cli/0.6.7/linux64' && \
    tar -xvzf bxcf.tgz && \
    rm bxcf.tgz && \
    /root/Bluemix_CLI/install_bluemix_cli

ENV PATH="/root:${PATH}"

# install git
RUN apt-get install --yes git

# install nano
RUN apt-get install --yes vim nano

# install nmon
RUN curl -L -o nmon https://github.com/axibase/nmon/releases/download/16d/nmon_x86_ubuntu && \
    chmod +x nmon

# install foxit reader - no silent installation option available
# RUN wget -O foxit.tgz 'http://cdn01.foxitsoftware.com/pub/foxit/reader/desktop/linux/2.x/2.4/en_us/FoxitReader2.4.1.0609_Server_x64_enu_Setup.run.tar.gz' && \
#     tar -xvzf foxit.tgz && \
#     rm foxit.tgz && \
#     mv FoxitReader.enu.setup.2.4.1.0609\(r08f07f8\).x64.run foxit.run

# install xpdf
RUN apt-get install --yes xpdf

# RUN cd Desktop/ && \
#     touch readme.txt && \
#     printf "" > readme.txt

EXPOSE 80
WORKDIR /root
ENV HOME=/home/ubuntu \
    SHELL=/bin/bash
HEALTHCHECK --interval=30s --timeout=5s CMD curl --fail http://127.0.0.1/api/health
ENTRYPOINT ["/startup.sh"]