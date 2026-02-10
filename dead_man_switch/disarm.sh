# File: /usr/local/bin/disarm.sh

FILE_DISARMED=/home/[user]/disarmed
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

if test  -f $FILE_DISARMED; then
    printf "${CYAN}ALREADY DISARMED.${NC}\n"
else
    touch $FILE_DISARMED
    printf "${GREEN}SUCCESSFULLY DISARMED.${NC}\n"
fi
