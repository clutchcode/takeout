# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# https://developer.amazon.com/sdk/fire/specifications.html
Device.create(name: 'Kindle Fire (1st Generation)',
              view: '',
              user_agent: Regexp.new('(Kindle Fire|Silk/1.0)').to_s,
              audio: 'mp3,aac,ogg',
              video: 'mp4,vp8',
              html5: 'mp3,mp4',
              width: 1024, height: 600)

Device.create(name: 'Kindle Fire (2nd Generation)',
              view: '',
              user_agent: Regexp.new('KFOT').to_s,
              audio: 'mp3,aac,ogg',
              video: 'mp4,vp8',
              html5: 'mp3,mp4',
              width: 1024, height: 600)

Device.create(name: 'Kindle Fire HD 7"',
              view: '',
              user_agent: Regexp.new('KFTT').to_s,
              audio: 'mp3,aac,ogg',
              video: 'mp4,vp8',
              html5: 'mp3,mp4',
              width: 1280, height: 800)

Device.create(name: 'Kindle Fire HD 8.9" Wi-Fi',
              view: '',
              user_agent: Regexp.new('KFJWI').to_s,
              audio: 'mp3,aac,ogg',
              video: 'mp4,vp8',
              html5: 'mp3,mp4',
              width: 1920, height: 1200)

Device.create(name: 'Kindle Fire HD 8.9" WAN',
              view: '',
              user_agent: Regexp.new('KFJWA').to_s,
              audio: 'mp3,aac,ogg',
              video: 'mp4,vp8',
              html5: 'mp3,mp4',
              width: 1920, height: 1200)

#
# Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.79 Safari/537.4

Device.create(name: 'Google Chrome Linux',
              view: '',
              user_agent: Regexp.new('Linux.*Chrome/').to_s,
              audio: 'm4a,mp3,ogg,oga,wav',
              video: 'mp4,m4v,ogv,ogm,webm,wav')

