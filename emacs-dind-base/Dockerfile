FROM piopirahl/docker-desktop:1.0.2

ARG USER_NAME=dockeruser
ARG USER_UID=1000
ARG DOCKER_GID=998
ARG FIXUID_VERSION=0.5.1

USER root

RUN USER=${USER_NAME} && \
    GROUP=${USER_NAME} && \
    curl -SsL https://github.com/boxboat/fixuid/releases/download/v${FIXUID_VERSION}/fixuid-${FIXUID_VERSION}-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -vp /etc/fixuid && \
    printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml

USER ${USER_NAME}:${USER_NAME}
WORKDIR /home/dockeruser

# DIND (Client only) - Emacs
RUN sudo apt-get update && \
    sudo apt-get install --no-install-recommends -y apt-transport-https ca-certificates \
        curl gnupg lsb-release bash-completion \
        ripgrep fd-find emacs net-tools figlet toilet && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    sudo apt-get update && \
    sudo apt-get -y install docker-ce-cli docker-compose && \
    sudo apt-get clean && sudo rm -vrf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sudo mkdir -vp /opt/scripts && \
    sudo chown -R ${USER_NAME}:${USER_NAME} /opt/scripts && \
    echo "source /etc/profile.d/bash_completion.sh" >> ~/.bashrc

# # Allow the user to access host docker daemon without sudo
RUN sudo groupadd -g ${DOCKER_GID} docker && \
    sudo usermod -aG docker ${USER_NAME}

COPY scripts/entrypoint.sh /opt/scripts

#Expose port 5901 to view display using VNC Viewer
EXPOSE 5901 6901
ENTRYPOINT ["/opt/scripts/entrypoint.sh"]