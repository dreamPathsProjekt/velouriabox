FROM piopirahl/docker-desktop:latest

USER dockeruser
WORKDIR /home/dockeruser

# DIND
RUN sudo apt-get update && \
    sudo apt-get install --no-install-recommends -y apt-transport-https ca-certificates \
        curl gnupg lsb-release bash-completion \
        ripgrep fd-find emacs net-tools && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    sudo apt-get update && \
    sudo apt-get -y install docker-ce-cli docker-compose && \
    sudo apt-get clean && sudo rm -vrf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sudo mkdir -vp /opt/scripts && \
    sudo chown -R dockeruser:dockeruser /opt/scripts && \
    echo "source /etc/profile.d/bash_completion.sh" >> ~/.bashrc
COPY scripts/entrypoint.sh /opt/scripts

#Expose port 5901 to view display using VNC Viewer
EXPOSE 5901 6901
ENTRYPOINT ["/opt/scripts/entrypoint.sh"]