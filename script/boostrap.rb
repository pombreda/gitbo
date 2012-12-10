#get redis up
#going install new redis server
  brew install redis
  redis-server /usr/local/etc/redis.conf

#get sidekiq running
  bundle exec sidekiq

#memecached
  #this is going to install latest version no matter what
  brew install memcached
  # maybe we could use: "brew install memcached unless memcached -h | head -1"

  #gets memcached instance running
  /usr/local/bin/memcached

  #migrate the database
  rake db:migrate