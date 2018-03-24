# Project Title

Blendin - we are one.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them

```
ruby '2.4.3'  
Rails 5.1.5
Redis
Sidekiq
Mailcatcher
```

### Installing

Please make sure you installed the following services:
* [Redis](https://redis.io/topics/quickstart) - Redis
* [Sidekiq](https://github.com/mperham/sidekiq) - Sidekiq
* [Mailcatcher](https://mailcatcher.me) - Mailcatcher

End with an example of getting some data out of the system or using it for a little demo

### Run in development

1. rails s
2. redis-server
3. bundle exec sidekiq
4. redis-server
5. mailcatcher

## Deployment

Deployment is handle by Heroku in two different stages. Staging  and Production
[blendinme.herokuapp.com](https://blendinme.herokuapp.com/) CNAME on [community.blendinnow.nl](http://community.blendinnow.nl)
[staging-blendin.herokuapp.com](https://staging-blendin.herokuapp.com/)

## DB

Set up live data in development

```
pg_restore --verbose --clean --no-acl --no-owner -h localhost -d blendin_development latest.dump
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
```

## Backup DB and export (only Admin can do this operation)

```
heroku pg:backups capture -a blendinme
curl -o latest.dump `heroku pg:backups public-url`
```

## Authors

* **Codegull LTD** - *Blendin Team* - [Codegull](https://codegull.com)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
