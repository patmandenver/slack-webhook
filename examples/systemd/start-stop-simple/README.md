# How to use on Ubuntu 16.04

Edit this script with your slack room/user emoji etc...
Copy this file over to /lib/systemd/system/ and enable it

`sudo cp slack-notify-start-stop.service  /lib/systemd/system/`

`sudo systemctl enable slack-notify-start-stop.service`

Then reboot and see the messages get posted to a slack room.

### Note about emojis

This example uses the emoji :ubuntu: to dsiplay the emoji as a user icon.
The :ubuntu: emoji does not exist in grab the image from this folder [custom emojis](/examples/custom-emojis)

If you are not familiar with how to do this here is a slack how-to article 
https://get.slack.help/hc/en-us/articles/206870177-Create-custom-emoji
