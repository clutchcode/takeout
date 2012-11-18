require 'net/http'

class UriCache
  CACHE_DIR = '/var/tmp/takeout/cache'

  def initialize
    @cache = ActiveSupport::Cache.lookup_store(:file_store, CACHE_DIR)
  end

  def get(url, expires = 24.hours)
    content = cache_get(url)
    unless content
      uri = URI(url)
      puts "getting #{uri}"
      content = Net::HTTP.get(uri)
      cache_put(url, content, expires)
    end
    content
  end

  def cache_key(url)
    url.gsub(/[^a-zA-Z0-9]/, '_')
  end

  def cache_get(url)
    @cache.fetch(cache_key(url))
  end

  def cache_put(url, content, expires)
    @cache.write(cache_key(url), content, :expires_in => expires)
  end
end