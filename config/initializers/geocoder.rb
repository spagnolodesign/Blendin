Geocoder.configure(
  #:lookup => :yandex,
  #:ip_lookup => :maxmind,
  #:api_key => "...",
  :timeout => 5,
  :units => :km,
  :cache => Rails.cache,
  #:cache_prefix => "..."
)
