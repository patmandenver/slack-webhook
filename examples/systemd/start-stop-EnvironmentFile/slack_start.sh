#!/bin/bash
#
# This creates an EnvironmentFile
# that is used by the slack-notify-start-stop.service`
#
######################################################

ENVIRONMENT_FILE="/etc/scack-webhooks/slack_environment_file"

ROOM="10x13_sensu"
USERNAME="ubuntu"
EMOJI="ubuntu"

TITLE="Server Startup"
MSG="Name         :    `hostname`"
MSG+="\nIP                  :   `ip route get 8.8.8.8 | awk '{print $NF; exit}'`"
MSG+=$start_text
MSG+="\nMemory   :   `cat /proc/meminfo | grep MemTotal | awk '{mem= $2/1048576; printf("%0.2g GiB", mem) ; exit}'`"

TITLE_RIGHT="Drive Status"
MSG_RIGHT="`df -h`"


echo "SLACK_WEBHOOK_ARG=\" -r $ROOM -u $USERNAME -e $EMOJI -t $TITLE -m $MESSAGE --title-right $TITLE_RIGHT --message-right $MSG_RIGHT\" > $ENVIRONMENT_FILE


