require 'yaml'

module ApiKey
  extend self

  def get_key(key_name)
    api_keys = YAML::load_file("#{ENV['HOME']}/.api_key")
    api_keys[key_name]
  end

end
