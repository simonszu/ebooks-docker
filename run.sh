#! /bin/bash

# Copy config to mounted config folder, if an empty folder is mounted
if [ ! -f /config/config.yaml ]; then
  cp /template/config.yaml.example /config/config.yaml
fi

if [ ! -f /config/ebooksrc ]; then
  cp /template/ebooksrc /config/ebooksrc
else
  cp /config/ebooksrc /root/.ebooksrc
fi



# Copy bot to mounted app folder if an empty folder is mounted
if [ ! -f /app/bots.rb ]; then
  cp /ebooks/bots.rb /app/bots.rb
else # If there is a bot in the app folder, copy it to the executable location
  cp -f /app/bots.rb /ebooks/bots.rb
fi

# Start cronjob for periodically refreshing the model
cron -f && tail -f /var/log/cron.log