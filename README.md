ebooks
======

Configure Twitter access
------------------------
1. Mount `/config`
2. Request a twitter oauth keypair (access token and consumer token, each with secret)
3. Edit `/config/config.yaml` and change the values accordingly

Modify your bot
---------------
1. Mount `/app`
2. Edit `bots.rb`
3. Restart the container. The file is copied to the proper location, then, and executed.