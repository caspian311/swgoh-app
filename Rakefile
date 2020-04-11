require 'sinatra/activerecord/rake'

require 'bundler'
Bundler.require(:default, ENV.fetch('RACK_ENV', 'development'))

require 'sinatra'

Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each do |f|
  load(f)
end
