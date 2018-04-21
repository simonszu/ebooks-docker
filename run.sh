#! /bin/bash

# Copy config to mounted config folder, if an empty folder is mounted

# Copy bot to mounted app folder if an empty folder is mounted
if [ ! -f /app/bots.rb ]; then
  cp /template/bots.rb /app/bots.rb
fi

# Copy modified config and bot to their appropriate location
cp /config/ebooksrc /root/.ebooksrc
cp /app/bots.rb /ebooks/bots.rb

# Generate the crontab
cat <<EOF > /etc/cron.d/cron
GEM_HOME=/usr/local/bundle

30 * * * * root /ebooks/import.sh >> /var/log/cron.log 2>&1
# An empty line is required at the end of this file for a valid cron file

EOF

# Make the crontab executable
chmod +x /etc/cron.d/cron

# Start cronjob for periodically refreshing the model
cron -f && tail -f /var/log/cron.log