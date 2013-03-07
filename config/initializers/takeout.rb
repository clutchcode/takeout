# takeout configuration
config_file = File.expand_path('takeout.yml', "#{Takeout::Application.root}/config")

APP_CONFIG = YAML.load(ERB.new(IO.read(config_file)).result)[Rails.env] if File.exists?(config_file)
APP_CONFIG ||= {}

APP_CONFIG[:image_cache_dir] ||= '/var/tmp/takeout/images'
APP_CONFIG[:movies_dir] ||= '/data/Video/Movies'
APP_CONFIG[:music_dir] ||= '/data/Music'
APP_CONFIG[:uri_cache_dir] ||= '/var/tmp/takeout/cache'

Takeout::Application.configure do
  config.music_dir = APP_CONFIG[:music_dir]
  config.movies_dir = APP_CONFIG[:movies_dir]
  config.image_cache_dir = APP_CONFIG[:image_cache_dir]
  config.uri_cache_dir = APP_CONFIG[:uri_cache_dir]
end
