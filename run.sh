#! /bin/bash

# Copy bot to mounted app folder if an empty folder is mounted
if [ ! -f /app/bots.rb ]; then
  envsubst < /template/bots.rb | tee /app/bots.rb
fi

# Template the config files with the environment vars
envsubst < /template/ebooksrc | tee /root/.ebooksrc
envsubst < /template/config.yaml | tee /ebooks/config.yaml

# Copy share-populating bots.rb to the real ebooks location
cp /app/bots.rb /ebooks/bots.rb

# Start cronjob for periodically refreshing the model
cron -f && tail -f /var/log/cron.log