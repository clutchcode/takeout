class ApplicationController < ActionController::Base
  protect_from_forgery

  # cover - 136x92, 228x154, 274x185, 506x342, 740x500, 755x510
  # cover - 131x92, 220x154, 264x185, 488x342, 713x500, 2174x1525
  # cover - 128x92, 214x154, 264x185, 488x342, 713x500, 2174x1525
  # backdrop - 300x169, 780x439, 1280x720, 1920x1080

  # kindle fire - 1024 x 600
  # kindle fire hd - 1280 × 800
  # kindle fire hd 8.9 - 1920 × 1200

  # nook - 1024 x 600

  # nexus 7 - 1280 x 800

  # ipad 1 - 1024 × 768
  # ipad 2 - 1024 × 768
  # ipad 3 - 2,048 × 1,536

  # iphone 1 - 480-by-320
  # iphone 3G - 480-by-320
  # iphone 4 - 960 × 640
  # iphone 5 - 640 × 1,136

  # 640x480 -
  # 800x600

  def device_type

  end

  def xpartial_name(partial)
    puts "checking #{partial}"
    if template_exists? partial + '.foo', controller_name, true
      partial + '.foo'
    else
      partial
    end
  end

  def template_name
    #if template_exists? action_name + '.foo', controller_name, false
    #  action_name + '.foo'
    #else
    #  action_name
    #end
    #action_name
    action_name
  end

  # returns [:image => data, :type => content-type]
  def embedded_music_cover(music_song)
    return nil unless music_song.has_cover?
    #@cache = ActiveSupport::Cache.lookup_store(:file_store, Takeout::Application.config.image_cache_dir) unless @cache
    #key = "cover:#{music_song.file_uri}".gsub(/[^a-zA-z0-9]/, '_')
    #cover = @cache.fetch(key)
    unless cover
      if music_song.file_uri =~ /\.mp3$/
        Mp3Info.open(music_song.file_uri) do |mp3info|
          data = mp3info.tag2.APIC
          if data and data =~ /(image\/[a-z]+)/
            type = $1
            index = data.index("\xFF\xD8\xFF\xE0")
            cover = { :image => data[index..-1], :type => type }
          end
        end
      elsif music_song.file_uri =~ /\.m4a$/
        mp4info = MP4Info.open(music_song.file_uri)
        data = mp4info.COVR
        cover = { :image => data, :type => 'image/jpeg' } if data
      end
      #@cache.write(key, cover, :expires_in => 30.days) if cover
    end
    cover
  end

end
