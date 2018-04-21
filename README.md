ebooks
======

Configure Twitter access
------------------------
1. Request a twitter oauth keypair (access token and consumer token, each with secret)
2. Define the environment variables `CONSUMER_KEY`, `CONSUMER_SECRET`, `ACCESS_TOKEN` and `ACCESS_TOKEN_SECRET`
3. Set the environment variable `USER` to your own twitter @-handle
4. Set the environment variable `BOT_USER` to your bot's @-handle

Modify your bot
---------------
1. Mount `/app`
2. Edit `bots.rb`
4. Restart the container. The file is copied to the proper location, then, and executed.

Fetch your tweets
-----------------
1. Mount `/ebooks/corpus` for persistent storage
2. Run `docker exec -it <container_name> /ebooks/import.sh`

Cronify tweet fetching
----------------------
1. A cronjob for refreshing your tweets json file is automatically generated on container startup
2. Fetch your tweets manually for the first time