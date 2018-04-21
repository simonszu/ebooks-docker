ebooks
======

Configure Twitter access
------------------------
1. Request a twitter oauth keypair (access token and consumer token, each with secret)
2. Define the environment variables `CONSUMER_KEY`, `CONSUMER_SECRET`, `ACCESS_TOKEN` and `ACCESS_TOKEN_SECRET`

Modify your bot
---------------
1. Mount `/app`
2. Edit `bots.rb`
3. Change the `Ebooks::Model.load` command in line 23, so that the argument is `model/<username>.model` where `username` is your twitter @-handle.
4. Restart the container. The file is copied to the proper location, then, and executed.

Fetch your tweets
-----------------
1. Set the environment variable `USER` to your twitter @-handle
3. Mount `/ebooks/corpus` for persistent storage
4. Run `docker exec -it <container_name> /ebooks/import.sh`

Cronify tweet fetching
----------------------
1. A cronjob for refreshing your tweets json file is automatically generated on container startup
2. Fetch your tweets manually for the first time