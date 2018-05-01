#! /bin/sh

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
envsubst < /template/import.sh | tee /ebooks/import.sh
chmod +x /ebooks/import.sh
echo 

# Copy share-populating bots.rb to the real ebooks location
cp /app/bots.rb /ebooks/bots.rb

# Build the model and stuff
echo "Fetching tweets, building model..."
/ebooks/import.sh

cd /ebooks

echo "Starting cron for periodic fetching, starting bot..."

/usr/sbin/crond -f -l 8 & ebooks start
