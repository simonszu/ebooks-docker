ebooks
======

Configure Twitter access
------------------------
1. Request a twitter oauth keypair (access token and consumer token, each with secret)
2. Define the environment variables `CONSUMER_KEY`, `CONSUMER_SECRET`, `ACCESS_TOKEN` and `ACCESS_TOKEN_SECRET`
3. Set the environment variable `USER` to your own twitter @-handle
4. Set the environment variable `BOT_USER` to your bot's @-handle

Modify your bot (if desired)
----------------------------
1. Mount `/app`
2. Edit `bots.rb`
4. Restart the container. The file is copied to the proper location, then, and executed.

Fetch your tweets
-----------------
1. Mount `/ebooks/corpus` for persistent storage
2. The tweets are automatically fetched on container startup, if the environment variables for OAuth access are properly set
3. The tweets are periodically fetched via cron
2. Run `docker exec -it <container_name> /ebooks/import.sh` to fetch them manually, between the cron intervals
