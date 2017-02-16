# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* Database migration form production to localhost
	heroku pg:backups capture
	curl -o latest.dump `heroku pg:backups public-url`
	pg_restore --verbose --clean --no-acl --no-owner -h localhost -d blendin_development latest.dump
	pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start