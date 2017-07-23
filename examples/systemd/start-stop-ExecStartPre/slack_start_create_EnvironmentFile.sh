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
TITLE="Left Title"
MSG="My Message\\\\\\\\nNew stuff"
TITLE_RIGHT="Right Title"
MSG_RIGHT="Message Right\\\\\\\\nNew stuff"


echo "ROOM=$ROOM" > $ENVIRONMENT_FILE
echo "USER=$USER" >> $ENVIRONMENT_FILE
echo "EMOJI=$EMOJI" >> $ENVIRONMENT_FILE
echo "LEVEL=$LEVEL" >> $ENVIRONMENT_FILE
echo "TITLE=\\\"$TITLE\\\"" >> $ENVIRONMENT_FILE
echo "MSG=\\\"$MSG\\\"" >> $ENVIRONMENT_FILE
echo "TITLE_RIGHT=\\\"$TITLE_RIGHT\\\"" >> $ENVIRONMENT_FILE
echo "MSG_RIGHT=\\\"$MSG_RIGHT\\\"" >> $ENVIRONMENT_FILE

 
