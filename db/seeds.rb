require 'net/http'
require 'uri'
require 'json'

def all_characters
  header = {
    'Content-Type': 'application/json'
  }
  uri = URI 'https://swgoh.gg/api/characters/'
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri, header)

  puts 'Requesting all characters from SWGOH'
  puts "HTTP GET #{uri}"

  response = http.request(request)

  raise 'Error!' unless response.is_a?(Net::HTTPSuccess)

  JSON.parse(response.body)
end

Message.create message: 'Success'

characters = all_characters
categories = characters.map { |f| f['alignment'] }.flatten.uniq
categories += characters.map { |f| f['categories'] }.flatten.uniq.sort

categories.each do |character_category|
  Category.create name: character_category
end

characters.each do |character_data|
  categories = character_data['categories'].map { |c| Category.find_by(name: c) }

  Character.create name:        character_data['name'],
                   description: character_data['description'],
                   categories:  categories,
                   image:       character_data['image']
end
