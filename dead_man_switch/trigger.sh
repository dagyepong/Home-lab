# File: /home/[user]/trigger.sh

FILE_DISARMED=/home/[user]/disarmed
LEAK_SCRIPT=/home/[user]/leak.sh

if test -f "$FILE_DISARMED"; then
    rm "$FILE_DISARMED"
else
    ./LEAK_SCRIPT  # publishes private key etc.
fi
