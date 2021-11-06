# Emacs-Dind Base Image

## Run the Desktop with VNC/noVNC

```Shell
docker run -d --rm \
-u $(id -u):$(id -g) \
--group-add=docker --group-add=sudo \
-e VNC_RESOLUTION=1920x1080 \
-p 127.0.0.1:6901:6901 -p 127.0.0.1:5901:5901 \
-v /var/run/docker.sock:/var/run/docker.sock \
--name emacs_dind \
dreampathsprojekt/emacs-dind-base:latest
```
