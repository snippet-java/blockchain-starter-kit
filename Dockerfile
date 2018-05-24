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
    apt-get -y -f install 

EXPOSE 80
WORKDIR /root
ENV HOME=/home/ubuntu \
    SHELL=/bin/bash
HEALTHCHECK --interval=30s --timeout=5s CMD curl --fail http://127.0.0.1/api/health
ENTRYPOINT ["/startup.sh"]