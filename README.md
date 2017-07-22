Slack Webook utility, with build script.

## Create a debian package

* Edit the build.sh script 
  * Replace `SLACK_URL_HOOK="UPDATE-ME"`
  * With your own webhook url ex. `SLACK_URL_HOOK="https://hooks.slack.com/services/T0437LKLE/B07C8KSS3/XXXXXXXXXX"`
* Build 
  * `sudo ./build.sh`
* Install
  * `sudo dpkg -i slack-webhooks_0.8-amd64.deb`
* Test
  * `slack-webhook -r "my_room" -m "test me"`

