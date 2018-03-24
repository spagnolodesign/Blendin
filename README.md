# README

# Install

	In order to run the project locally please make sure to install the following services:

	1. ruby '2.4.3'  
	2. Rails 5.1.5
	3. Redis [link](https://redis.io/topics/quickstart)
	4. Sidekiq [link](https://github.com/mperham/sidekiq)
	5. Mailcatcher [link](https://mailcatcher.me)

# Run project in development

	1. rails s
	2. redis-server
	3. bundle exec sidekiq
	4. redis-server
	5. mailcatcher

# Set up DB with data from live website.

	pg_restore --verbose --clean --no-acl --no-owner -h localhost -d blendin_development latest.dump
	pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start

# Backup DB and export (only Admin can do this operation)

	heroku pg:backups capture -a blendinme
	curl -o latest.dump `heroku pg:backups public-url`

# Production
	[link](https://blendinme.herokuapp.com/) CNAME on http://community.blendinnow.nl

# Staging
	[link](https://staging-blendin.herokuapp.com/)
