# How to use on Ubuntu 16.04

Edit this script with your slack room/user emoji etc...
Copy this file over to /lib/systemd/system/ and enable it

`sudo cp slack-notify-start-stop.service  /lib/systemd/system/`

`sudo systemctl enable slack-notify-start-stop.service`

Then reboot and see the messages get posted to a slack room.
