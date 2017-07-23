#!/bin/bash
#
# This creates an EnvironmentFile
# that is used by the slack-notify-start-stop.service`
#
######################################################

# Note!!
# returns \n = \\\\\\\\n

ENVIRONMENT_FILE="/etc/slack-webhooks/slack_environment_file"

ROOM=dev_ops
USER=ubuntu
EMOJI=ubuntu
LEVEL=info
TITLE="Server Shutting Down!"
TITLE_RIGHT="Drive Status"

#############################################
#
# A more intersting message that shows
# hostname/IP/Memory
#
#############################################
MSG="Name           :    `hostname`"
MSG+="\\\\\\\\n"
MSG+="IP                  :   `ip route get 8.8.8.8 | awk '{print $NF; exit}'`"
MSG+="\\\\\\\\n"
MSG+="Memory       :   `cat /proc/meminfo | grep MemTotal | awk '{mem= $2/1048576; printf("%0.2g GiB",mem) ; exit}'`"


#############################################
#
# A more intersting Extra infor that shows
# Current drive status 
# Have a simpler way to do this? Tell me and
# I will update it
#
#############################################
MSG_RIGHT=$(df -h | awk '{print $2 " " $4 " " $5 " " $6}' | tr '\n' ',' | sed 's%,%\\\\\\\\n%g')

######################################################
#
# Here is an example to just list the drives you want
# Comment out the one above and uncomment this
# Change the ($6 == "/") to the drives you want displayed
#
#######################################################
#MSG_RIGHT=$(df -h | awk '{ print $2 " " $4 " " $5 " " $6}' | head -1)
#MSG_RIGHT+="\\\\\\\\n"
#MSG_RIGHT+=$(df -h | awk '{ if ($6 == "/") print $2 " " $4 " " $5 " " $6}' | tr '\n' ',' | sed 's%,%\\\\\\\\n%g')
#MSG_RIGHT+=$(df -h | awk '{ if ($6 == "/dev") print $2 " " $4 " " $5 " " $6}' | tr '\n' ',' | sed 's%,%\\\\\\\\n%g')

echo "ROOM=$ROOM" > $ENVIRONMENT_FILE
echo "USER=$USER" >> $ENVIRONMENT_FILE
echo "EMOJI=$EMOJI" >> $ENVIRONMENT_FILE
echo "LEVEL=$LEVEL" >> $ENVIRONMENT_FILE
echo "TITLE=\\\"$TITLE\\\"" >> $ENVIRONMENT_FILE
echo "MSG=\\\"$MSG\\\"" >> $ENVIRONMENT_FILE
echo "TITLE_RIGHT=\\\"$TITLE_RIGHT\\\"" >> $ENVIRONMENT_FILE
echo "MSG_RIGHT=\\\"$MSG_RIGHT\\\"" >> $ENVIRONMENT_FILE

 
