# README


* Database migration form production to localhost
	heroku pg:backups capture
	curl -o latest.dump `heroku pg:backups public-url`
	pg_restore --verbose --clean --no-acl --no-owner -h localhost -d blendin_development latest.dump
	pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
