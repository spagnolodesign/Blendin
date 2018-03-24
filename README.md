# README



# Install

	In order to run the project locally please make sure you are running you've installed the following services:

	1. ruby '2.4.3'  
	2. Rails 5.1.5
	3. Redis [quick start install Redis](https://redis.io/topics/quickstart)
	4. Sidekiq [quick start install Sidekiq](https://github.com/mperham/sidekiq)
	5. Mailcatcher [quick start install Mailcatcher] https://mailcatcher.me/

# Run project in development

	1. `rails s`
	2. `redis-server`
	3. `bundle exec sidekiq`
	4. `redis-server`
	4. `mailcatcher`

# Set up DB with data from live website.

	1. `pg_restore --verbose --clean --no-acl --no-owner -h localhost -d blendin_development latest.dump`
	2. `pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start`

# Backup DB and export
	heroku pg:backups capture
	curl -o latest.dump `heroku pg:backups public-url`
