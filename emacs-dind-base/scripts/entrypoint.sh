#!/usr/bin/env bash

set -e

# Terminal Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
GREY='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

trap ctrl_c INT
function ctrl_c() {
  exit 0
}

eval "$(fixuid)"

# entrypoint.sh file for starting the xvfb with better screen resolution, configuring and running the vnc server.
rm /tmp/.X1-lock 2> /dev/null &
/opt/noVNC/utils/launch.sh --vnc localhost:"${VNC_PORT}" --listen "${NO_VNC_PORT}" &
vncserver "${DISPLAY}" -depth "${VNC_COL_DEPTH}" -geometry "${VNC_RESOLUTION}" -SecurityTypes None -localhost no --I-KNOW-THIS-IS-INSECURE &

banner=$(figlet -f slant -t -k VELOURIA - BOX)
echo -e "${GREEN}${banner}${NC}"

colored_lyrics=$(cat <<EOF

${BLUE}We will wade in the shine of the ever${NC}
${BLUE}We will wade in the tides of the summer${NC}
${YELLOW}Every summer...${NC}
${GREY}Every summer...${NC}

${GREEN}Forever green${NC}
${BLUE}I know she's${NC} ${RED}here${NC}
${CYAN}In California..${NC}
EOF
)
echo -e "${colored_lyrics}\n"
wait
