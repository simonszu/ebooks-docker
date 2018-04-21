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

# Generate the crontab
cat <<EOF > /etc/cron.d/cron
GEM_HOME=/usr/local/bundle

30 * * * * cd /ebooks; ebooks archive $USER >> /var/log/cron.log 2>&1
45 * * * * cd /ebooks; ebooks consume corpus/$USER.json >> /var/log/cron.log 2>&1
# An empty line is required at the end of this file for a valid cron file.1
EOF

# Make the crontab executable
chmod +x /etc/cron.d/cron

# Start cronjob for periodically refreshing the model
cron -f && tail -f /var/log/cron.log