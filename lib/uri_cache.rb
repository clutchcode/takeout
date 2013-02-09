require 'net/http'

class UriCache
  USER_AGENT = 'Takeout/1.0'

  def initialize
    @cache = ActiveSupport::Cache.lookup_store(:file_store, Takeout::Application.config.uri_cache_dir)
  end

  def get(url, expires = 24.hours, limit = 4)
    raise ArgumentError, 'redirect limit exceeded' if limit == 0
    content = cache_get(url)
    unless content
      uri = URI(url)
      puts "getting #{uri}"

      #request = Net::HTTP::Get.new(uri.path)
      #request.add_field('User-Agent', USER_AGENT)
      #response = Net::HTTP.start(uri.host, uri.port) {|http| http.request(request) }

      begin
        response = Net::HTTP.get_response(uri)
        case response
          when Net::HTTPSuccess then
            content = response.body
          when Net::HTTPRedirection then
            location = response['location']
            puts "redirect to #{location}"
            return get(location, expires, limit - 1)
          else
            expires = 1.hour
            content = {}
        end
      rescue Exception => e
        puts e.message
        content = {}
        expires = 5.minutes
      end
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