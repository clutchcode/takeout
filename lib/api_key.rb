require 'yaml'

module ApiKey
  extend self

  API_KEYS = {
    'tmdb3' => '',
    'fanart' => '',
    'lastfm2' => ''
  }

  def get_key(key_name)
    api_keys = YAML::load_file("#{ENV['HOME']}/.api_key")
    api_keys[key_name] || API_KEYS[key_name]
  end

end
