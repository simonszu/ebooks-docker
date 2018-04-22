#! /bin/bash

# Copy bot to mounted app folder if an empty folder is mounted
# Substitute environment variables in this step
if [ ! -f /app/bots.rb ]; then
  envsubst < /template/bots.rb | tee /app/bots.rb
fi

# Template the config files with the environment vars
envsubst < /template/ebooksrc | tee /root/.ebooksrc

# Copy share-populating bots.rb to the real ebooks location
cp /app/bots.rb /ebooks/bots.rb

# Fetch the first few tweets to create a model, if it isn't available yet
if [ ! -f /ebooks/corpus/$USER.json ]; then
  /ebooks/import.sh
fi

cron -f && tail -f /var/log/cron.log