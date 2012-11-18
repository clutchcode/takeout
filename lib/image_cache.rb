require 'net/http'
require 'fileutils'

class ImageCache
  def initialize
    @cache_dir = Takeout::Application.config.image_cache_dir
  end

  def exists?(url)
    cache_file = cache_file_name(url)
    File.exists? cache_file ? cache_file : nil
  end

  def fetch(url, content = nil)
    cache_file = cache_file_name(url)
    unless File.exists? cache_file
      if url =~ /^file:\/\//
        path = url[7..-1]
        unless content
          puts "reading #{path}"
          content = File.open(path).read
        end
      else
        unless content
          uri = URI(url)
          puts "getting #{uri}"
          content = Net::HTTP.get(uri)
        end
      end
      FileUtils.mkdir_p(File.dirname(cache_file))
      File.open(cache_file, "wb") do |file|
        puts "writing #{cache_file}"
        file.write content
      end
    end
    cache_file
  end

  private

  def cache_file_name(url)
    url = "#{url}index.html" if url =~ /^http:\/\/.+\/$/
    if url =~ /^(file:|http:)(.*)/
      url = $2
    end
    path = url.gsub(/[^a-zA-Z0-9\/\.]/, '_')
    "#{@cache_dir}/#{path}".gsub(/\/+/, '/')
  end
end
