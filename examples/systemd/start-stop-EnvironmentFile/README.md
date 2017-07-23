# How to use on Ubuntu 16.04

Edit this script with your slack room/user emoji etc...
Copy this file over to /lib/systemd/system/ and enable it

`sudo cp slack-notify-start-stop.service  /lib/systemd/system/`

`sudo systemctl enable slack-notify-start-stop.service`


## Create the folder /etc/slack-webhooks and copy EnvironmentFile there

`sudo mkdir /etc/slack-webhooks/`

`sudo cp slack_enfironment_file /etc/slack-webhooks/`


Then reboot and see the messages get posted to a slack room.
