#!/bin/sh

cd /ebooks
/usr/local/bundle/bin/ebooks archive $USER

if [ ! -f model/$USER.model ]
then
  /usr/local/bundle/bin/ebooks consume corpus/$USER.json
else
  /usr/local/bundle/bin/ebooks append model/$USER.model corpus/$USER.json
fi
