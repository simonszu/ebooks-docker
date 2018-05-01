#!/bin/sh

cd /ebooks
/usr/local/bundle/bin/ebooks archive $USER
/usr/local/bundle/bin/ebooks consume corpus/$USER.json
