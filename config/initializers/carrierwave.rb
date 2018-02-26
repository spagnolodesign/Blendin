CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => 'AKIAIOPPK7RU4V34P6MQ',
      :aws_secret_access_key  => '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',
      :region                 => 'eu-central-1'
  }

  config.fog_directory    = "berryhoop"
  config.fog_public       = false
end
