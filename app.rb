require 'bundler'

Bundler.require(:default, ENV.fetch('RACK_ENV', 'development'))

class MyApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  register Sinatra::Reloader

  require File.join(root, '/config/initializers/autoloader.rb')
end

after_reload do
  puts 'reloaded'
end

configure do
  enable :cross_origin
  enable :logging
  enable :reloader

  set :bind, '0.0.0.0'
end

before do
  response.headers['Access-Control-Allow-Origin'] = '*'
end

options '*' do
  response.headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS, DELETE, PUT'
  response.headers['Access-Control-Allow-Headers'] = 'Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token'
  response.headers['Access-Control-Allow-Origin'] = '*'
  200
end
