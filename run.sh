#! /bin/bash

if [ ! -f /config/config.yaml ]; then
  cp /template/config.yaml.example /config/config.yaml
fi

cp -f /app/bots.rb /ebooks/bots.rb