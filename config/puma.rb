# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum, this matches the default thread size of Active Record.
#
# threads_count = 1
# threads threads_count, threads_count
# port        ENV.fetch("PORT") { 3000 }
# environment ENV.fetch("RAILS_ENV") { "development" }
# workers 1
# preload_app!
#
# on_worker_boot do
#   @sidekiq_pid ||= spawn('bundle exec sidekiq -t 1')
#   ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
# end
#
# on_restart do
#   Sidekiq.redis.shutdown { |conn| conn.close }
# end
#
# plugin :tmp_restart

workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
