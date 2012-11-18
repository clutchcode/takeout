require 'net/http'
require 'cgi'
require 'json'
require 'uri_cache'

class ApiEngine
  attr_accessor :json

  def initialize(name, host = nil, port = 80)
    @name = name
    @host = host
    @port = port
    @cache = UriCache.new
  end

  def get(uri, params = {})
    if params.size > 0
      uri = uri.dup
      params.each do |key, value|
        uri += uri.index('?') ? '&' : '?'
        uri += "#{CGI.escape(key)}=#{CGI.escape(value)}" if key and value
      end
    end

    #puts "#{@name}: #{uri}"
    content = @cache.get("http://#{@host}:#{@port}#{uri}", 180.days)

    if @json
      begin
        content = JSON.parse(content)
      rescue
        content = nil
      end
    end
    content
  end
end