#! /bin/bash

# Copy bot to mounted app folder if an empty folder is mounted
# Substitute environment variables in this step
if [ ! -f /app/bots.rb ]; then
  echo "Installing bot..."
  envsubst < /template/bots.rb | tee /app/bots.rb
  echo
fi

# Template the config files with the environment vars
echo "Configuring CLI access for tweet fetching..."
envsubst < /template/ebooksrc | tee /root/.ebooksrc
echo 

# Copy share-populating bots.rb to the real ebooks location
cp /app/bots.rb /ebooks/bots.rb

# Fetch the first few tweets to create a model, if it isn't available yet
if [ ! -f /ebooks/corpus/$USER.json ]; then
  echo "No corpus found, proceeding with initial import..."
  /ebooks/import.sh
fi

cd /ebooks

echo "Starting cron for periodic fetching, starting bot..."

cron -f & ebooks start
